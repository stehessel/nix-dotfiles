{ config, pkgs, libs, ... }:
let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  home-manager = import sources.home-manager { inherit pkgs; };
  niv = import sources.niv {};
in
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  imports = [
    ./role/work-macos
    ./user/blueyonder
  ];
}
