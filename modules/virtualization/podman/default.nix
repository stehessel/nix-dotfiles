{ pkgs, lib, ... }:
{
  xdg.configFile."containers" = {
    source = ./config;
    recursive = true;
  };
}
