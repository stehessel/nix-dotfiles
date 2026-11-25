{
  inputs,
  llms,
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
    pkgs.devenv
    pkgs.kitty
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit llms pkgs-stable;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.shesselm = {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
        ../../profiles/redhat
        ../../roles/work-macos
      ];
    };
  };

  nix-homebrew = {
    autoMigrate = true;
    enable = true;
    enableRosetta = false; # Forces native ARM64 compilation/execution.
    user = "shesselm";
  };

  nix.enable = false;

  # Determinate Nix includes this file from its generated nix.conf.
  environment.etc."nix/nix.custom.conf" = let
    caches = {
      "https://cache.numtide.com" = "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=";
      "https://hyprland.cachix.org" = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
      "https://nix-community.cachix.org" = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      "https://stehessel.cachix.org" = "stehessel.cachix.org-1:lvYhj5BePS/SBMUvSRlDPy5galoS8MszATOdfEZQ0Qw=";
    };
  in {
    # Allow activation to replace the installer's comment-only default file.
    knownSha256Hashes = ["3bd68ef979a42070a44f8d82c205cfd8e8cca425d91253ec2c10a88179bb34aa"];
    text = ''
      extra-substituters = ${builtins.concatStringsSep " " (builtins.attrNames caches)}
      extra-trusted-public-keys = ${builtins.concatStringsSep " " (builtins.attrValues caches)}
    '';
  };

  users.users.shesselm = {
    name = "shesselm";
    home = "/Users/shesselm";
    shell = pkgs.fish;
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
    enable = true;
    enableFishIntegration = true;
    onActivation = {
      autoUpdate = true;
    };
    taps = [
      "koekeishiya/formulae"
      "openshift-online/sre-tools"
    ];
    brews = [
      {name = "docker-buildx";}
      {name = "go-task";}
      {name = "prometheus";}
      {name = "r";}
      # {
      #   name = "skhd";
      #   trusted = true;
      # }
      # {
      #   name = "yabai";
      #   trusted = true;
      # }
      {name = "openshift-online/sre-tools/backplane-cli";}
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
      "maccy"
      "quarto"
      "rstudio"
      "shottr"
      "slack"
      "syncthing-app"
      "tailscale-app"
      "zoom"
    ];
  };

  networking = {
    applicationFirewall = {
      allowSigned = true;
      allowSignedApp = true;
      blockAllIncoming = true;
      enable = true;
      enableStealthMode = true;
    };
    # dns = [
    #   "1.1.1.1"
    #   "1.0.0.1"
    #   "2606:4700:4700::1111"
    #   "2606:4700:4700::1001"
    # ];
    knownNetworkServices = [
      "Thunderbold Bridge"
      "USB 10/100/1000 LAN"
      "Wi-Fi"
    ];
  };

  # fonts.packages = [
  #   pkgs.nerd-fonts.fira-code
  # ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      CustomUserPreferences = {
        # See https://stackoverflow.com/questions/21878482/what-do-the-parameter-values-in-applesymbolichotkeys-plist-dict-represent.
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Open mission control with 'Option + Up'.
            "32" = {
              enabled = true;
              value = {
                parameters = [65535 126 11010048];
                type = "standard";
              };
            };
            # Open mission control with 'Option + Up'.
            "34" = {
              enabled = true;
              value = {
                parameters = [65535 126 11141120];
                type = "standard";
              };
            };
            # Switch to space 1 with 'Option + 1'.
            "118" = {
              enabled = true;
              value = {
                parameters = [49 18 524288];
                type = "standard";
              };
            };
            # Switch to space 2 with 'Option + 2'.
            "119" = {
              enabled = true;
              value = {
                parameters = [50 19 524288];
                type = "standard";
              };
            };
            # Switch to space 3 with 'Option + 3'.
            "120" = {
              enabled = true;
              value = {
                parameters = [51 20 524288];
                type = "standard";
              };
            };
            # Switch to space 4 with 'Option + 4'.
            "121" = {
              enabled = true;
              value = {
                parameters = [52 21 524288];
                type = "standard";
              };
            };
            # Switch to space 5 with 'Option + 5'.
            "122" = {
              enabled = true;
              value = {
                parameters = [53 22 524288];
                type = "standard";
              };
            };
          };
        };
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
    primaryUser = "shesselm";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
