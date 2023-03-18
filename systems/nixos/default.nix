{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = rec {
    initrd.systemd.enable = true;

    # Enable only bootspec before enabling lanzaboote on initial setup of secure boot.
    # See https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    bootspec.enable = true;

    lanzaboote = {
      enable = false;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      systemd-boot = {
        # Lanzaboote currently replaces the systemd-boot module.
        # This setting is usually set to true in configuration.nix
        # generated at installation time. So we force it to false
        # for now.
        enable = if lanzaboote.enable then lib.mkForce false else true;
        configurationLimit = 30;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  # Secure boot key manager
  environment.systemPackages = with pkgs; [
    sbctl
  ];

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
      fonts = ["FiraCode"];
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
      "--avoid '^(wayland|hyprland|kitty|foot)$'"
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
      defaultSession = "hyprland";
      lightdm.enable = true;

      sessionCommands = ''
        export XKB_DEFAULT_OPTIONS='caps:escape'
      '';
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
      connect-timeout = 5  # in seconds
      experimental-features = ca-derivations nix-command flakes
      fallback = true
      keep-going = true
      log-lines = 25
      max-free = 1000000000 # 1 GB
      min-free = 256000000  # 256 MB
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      substituters = [
        # Content addressed cache
        # "https://cache.ngi0.nixos.org"
        # See https://nixos.wiki/wiki/Maintainers:Fastly#Cache_v2_plans
        "https://aseipp-nix-cache.freetls.fastly.net"
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://stehessel.cachix.org"
      ];
      trusted-public-keys = [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "22.11";
}
