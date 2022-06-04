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

  # Autostart window manager
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      export XKB_DEFAULT_OPTIONS="caps:escape"
      exec river
    fi
  '';

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement.
      dockerCompat = true;
    };
  };

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-going = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "22.11";
}
