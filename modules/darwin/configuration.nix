{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  environment = {
    darwinConfig = "$HOME/.config/nixpkgs/modules/darwin/configuration.nix";
    loginShell = pkgs.fish;
    systemPackages =
      [
        pkgs.vim
      ];
  };

  users.users.stephan = {
    name = "stephan";
    home = "/Users/stephan";
  };

  home-manager.users.stephan = { pkgs, ... }: {
    imports = [ /Users/stephan/nix-home/macos.nix ];
  };

  system.defaults = {
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

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
