{ pkgs, lib, ... }:
{
  xdg.configFile."lf" = {
    source = ./config;
    recursive = true;
  };
}
