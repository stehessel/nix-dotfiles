{ config, pkgs, home-manager, ... }:

{
  # Make `darwin-rebuild` available in shell.
  programs.fish.enable = true;
  environment.loginShell = pkgs.fish;
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

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
    buildCores = 6;
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      interval = { Hour = 12; };
    };
    maxJobs = 12;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
