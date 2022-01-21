{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  imports = [
    ./role/work-macos
    ./user/redhat
  ];
}
