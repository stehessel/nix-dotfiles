{ pkgs, lib, ... }:
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  imports = [
    ./roles/linux
    ./profiles/stehessel
  ];
}
