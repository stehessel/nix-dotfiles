{ config, lib, pkgs, ... }:
{
  xdg.configFile."taskwarrior" = {
    source = ./config;
    recursive = true;
  };
}
