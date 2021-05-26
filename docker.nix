{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./role/docker
    ./user/blueyonder
  ];
}
