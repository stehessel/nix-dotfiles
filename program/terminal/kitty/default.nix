{ config, lib, pkgs, ... }:
{
  xdg.configFile."kitty" = {
    source = ./config;
    recursive = true;
  };
}
