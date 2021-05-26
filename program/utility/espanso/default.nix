{ config, lib, pkgs, ... }:
{
  xdg.configFile."espanso" = {
    source = ./config;
    recursive = true;
  };
}
