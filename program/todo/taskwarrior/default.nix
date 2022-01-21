{ pkgs, lib, ... }:
{
  xdg.configFile."taskwarrior" = {
    source = ./config;
    recursive = true;
  };
}
