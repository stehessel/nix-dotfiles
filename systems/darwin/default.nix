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
      "docker-buildx"
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
      "texlive"
      "yabai"
      "z3"
      "zerotier-one"
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
