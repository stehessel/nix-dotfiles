{ config, lib, pkgs, ... }:
{
  xdg.configFile."foot" = {
    source = ./config;
    recursive = true;
  };
}
