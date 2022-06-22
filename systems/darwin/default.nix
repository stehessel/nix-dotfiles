{ pkgs, ... }:

{
  environment.shells = [ pkgs.bashInteractive pkgs.fish ];
  programs.bash.enable = true;
  programs.fish.enable = true;

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
    autoUpdate = true;
    cleanup = "zap";
    global.brewfile = true;
    global.noLock = true;

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
      "skhd"
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
      "rancher"
      "slack"
      "syncthing"
      "wezterm"
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

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
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
        autohide-delay = "0.0";
        autohide-time-modifier = "1.0";
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
        "com.apple.sound.beep.volume" = "0.000";
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

  # Upstream PR: https://github.com/LnL7/nix-darwin/pull/228
  # security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;
  users.nix.configureBuildUsers = true;
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
      interval = { Hour = 12; };
    };
    useSandbox = false;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
