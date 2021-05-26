{ config, lib, pkgs, ... }:
{
  xdg.configFile."lf" = {
    source = ./config;
    recursive = true;
  };
}
