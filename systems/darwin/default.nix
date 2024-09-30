{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.shells = [pkgs.bashInteractive pkgs.fish];
  programs.bash.enable = true;
  programs.fish.enable = true;

  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = [
    (import (fetchTarball "https://install.devenv.sh/latest")).default
    pkgs.kitty
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs-stable;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.stephan = {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
        ../../profiles/redhat
        ../../roles/work-macos
      ];
    };
  };

  users.users.stephan = {
    name = "stephan";
    home = "/Users/stephan";
  };

  services = {
    skhd = {
      enable = false;
      package = pkgs.skhd;
      skhdConfig = ''
        cmd + shift - b : fish -c "echo test"
      '';
    };
    yabai = {
      enable = false;
      package = pkgs.yabai;
      config = {
        focus_follows_mouse = "autoraise";
        mouse_follows_focus = "on";
        window_placement = "second_child";
        window_opacity = "off";
        top_padding = 36;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;

        window_border_width = 6;
        active_window_border_color = "0xff775759";
        normal_window_border_color = "0xff555555";
      };
    };
  };

  homebrew = {
    enable = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    global.brewfile = true;

    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "homebrew/test-bot"
      "koekeishiya/formulae"
      "mutagen-io/mutagen"
      "nrlquaker/createzap"
    ];
    brews = [
      "apache-arrow"
      "coreutils"
      "fribidi"
      "gcc"
      "gdal"
      "go-task"
      "harfbuzz"
      "libgit2"
      "libtiff"
      "llvm"
      "pkg-config"
      "prometheus"
      "r"
      "skhd"
      "yabai"
      "z3"
    ];
    casks = [
      "adobe-acrobat-reader"
      "app-cleaner"
      "calibre"
      "clipy"
      "dbeaver-community"
      "font-fira-code-nerd-font"
      "google-chrome"
      "inkscape"
      "quarto"
      "rstudio"
      "shottr"
      "slack"
      "syncthing"
      "zoom"
    ];
  };

  networking = {
    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    knownNetworkServices = [
      "Thunderbold Bridge"
      "USB 10/100/1000 LAN"
      "Wi-Fi"
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = ["FiraCode"];
    })
  ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      # Firewall
      alf = {
        globalstate = 1;
        allowsignedenabled = 1;
        allowdownloadsignedenabled = 1;
        stealthenabled = 1;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 1.0;
        tilesize = 75;
        static-only = false;
        showhidden = false;
        show-recents = false;
        show-process-indicators = true;
        orientation = "bottom";
        mru-spaces = false;
      };

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.swipescrolldirection" = false;
        # Allow key repeat
        ApplePressAndHoldEnabled = false;
        # Delay before repeating keystrokes
        InitialKeyRepeat = 10;
        # Delay between repeated keystrokes upon holding a key
        KeyRepeat = 1;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        # Makes fonts look better. See https://tonsky.me/blog/monitors.
        AppleFontSmoothing = 0;
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;
    # builders = ssh-ng://builder@linux-builder x86_64-linux /etc/nix/builder_ed25519 4 - - - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=
    # builders-use-substitutes = true
    extraOptions = ''
      connect-timeout = 5  # in seconds
      download-buffer-size = 268435456
      experimental-features = ca-derivations nix-command flakes
      fallback = true
      keep-going = true
      log-lines = 25
      max-free = 1000000000 # 1 GB
      min-free = 256000000  # 256 MB
    '';
    gc = {
      automatic = true;
      interval = {
        Hour = 12;
      };
    };
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = false;
      substituters = [
        # See https://nixos.wiki/wiki/Maintainers:Fastly#Cache_v2_plans
        # "https://aseipp-nix-cache.freetls.fastly.net"
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        "https://stackrox.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "stackrox.cachix.org-1:Wnn8TKAitOTWKfTvvHiHzJjXy0YfiwoK6rrVzXt/trA="
      ];
      trusted-users = [
        "root"
        "@admin"
      ];
      sandbox = false;
      use-xdg-base-directories = true;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
