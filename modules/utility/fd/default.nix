{ lib, pkgs, ... }:
{
  xdg.configFile."fd" = {
    source = ./config;
    recursive = true;
  };
}
