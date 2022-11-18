{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
  ];

  boot = {
    initrd.systemd.enable = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 30;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
  };

  systemd.coredump.enable = false;

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

  # Memory
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid '^(wayland|river|kitty|foot)$'"
      "--prefer '^(electron|libreoffice|gimp|brave)$'"
    ];
  };


  # Audio
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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

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
          (_: rec {
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
      experimental-features = ca-derivations nix-command flakes
      keep-going = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
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
