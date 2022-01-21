{ pkgs, lib, ... }:
{
  xdg.configFile."cargo" = {
    source = ./config;
    recursive = true;
  };
}
