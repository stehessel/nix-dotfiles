{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.vim
    ];

  users.users.stephan = {
    name = "stephan";
    home = "/Users/stephan";
  };

  home-manager.users.stephan = { pkgs, ... }: {
    imports = [ /Users/stephan/nix-home/macos.nix ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/modules/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/modules/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
