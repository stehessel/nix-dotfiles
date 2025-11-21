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
    users.shesselm = {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
        ../../profiles/redhat
        ../../roles/work-macos
      ];
    };
  };

  nix.enable = false;

  users.users.shesselm = {
    name = "shesselm";
    home = "/Users/shesselm";
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
    onActivation = {
      autoUpdate = true;
    };
    taps = [
      "homebrew/test-bot"
      "koekeishiya/formulae"
    ];
    brews = [
      "docker-buildx"
      "go-task"
      "prometheus"
      "r"
      "skhd"
      "texlive"
      "yabai"
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
      "zerotier-one"
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
