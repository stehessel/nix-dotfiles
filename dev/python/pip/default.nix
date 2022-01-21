{ pkgs, lib, ... }:
{
  xdg.configFile."pip" = {
    source = ./config;
    recursive = true;
  };
}
