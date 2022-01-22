{ pkgs, lib, ... }:
{
  xdg.configFile."kitty" = {
    source = ./config;
    recursive = true;
  };
}
