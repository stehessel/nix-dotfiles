{ config, lib, pkgs, ... }:
{
  xdg.configFile."tasklite" = {
    source = ./config;
    recursive = true;
  };
}
