{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    initrd.systemd.enable = false;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  networking = {
    hostName = "thinkpad";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };
  programs.nm-applet.enable = true;

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "FiraCode";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  services = {
    printing.enable = true;
    tlp.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Login shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Screen share
  # xdg.portal = {
  #   enable = true;
  #   gtkUsePortal = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   wlr.enable = true;
  # };

  # Login manager
  services.xserver = {
    enable = true;

    libinput.enable = true;

    displayManager = {
      autoLogin = {
        enable = true;
        user = "stephan";
      };
      defaultSession = "river";
      lightdm.enable = true;

      sessionCommands = ''
        export XKB_DEFAULT_OPTIONS='caps:escape'
      '';

      sessionPackages = [
        (pkgs.river.overrideAttrs
          (prevAttrs: rec {
            postInstall =
              let
                riverSession = ''
                  [Desktop Entry]
                  Name=River
                  Comment=Dynamic Wayland compositor
                  Exec=river
                  Type=Application
                '';
              in
              ''
                mkdir -p $out/share/wayland-sessions
                echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
              '';
            passthru.providedSessions = [ "river" ];
          })
        )
      ];
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement.
      dockerCompat = true;
    };
  };

  nix = {
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = ca-derivations nix-command flakes
      keep-going = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      substituters = [
        # See https://nixos.wiki/wiki/Maintainers:Fastly#Cache_v2_plans
        "https://aseipp-nix-cache.freetls.fastly.net"
        # Content addressed cache
        # "https://cache.ngi0.nixos.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "22.11";
}
