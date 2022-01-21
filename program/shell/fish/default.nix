{ pkgs, lib, ... }:
{
  xdg.configFile."fish" = {
    source = ./config;
    recursive = true;
  };
}
