{ config, lib, pkgs, ... }:
{
  xdg.configFile."waybar" = {
    source = ./config;
    recursive = true;
  };
}
