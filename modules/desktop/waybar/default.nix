{ pkgs, lib, ... }:
{
  xdg.configFile."waybar" = {
    source = ./config;
    recursive = true;
  };
}
