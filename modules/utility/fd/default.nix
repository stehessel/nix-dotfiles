{ pkgs, lib, ... }:
{
  xdg.configFile."fd" = {
    source = ./config;
    recursive = true;
  };
}
