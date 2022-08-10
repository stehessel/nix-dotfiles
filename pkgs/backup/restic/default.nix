{ lib, pkgs, ... }:
{
  xdg.configFile."restic" = {
    source = ./config;
    recursive = true;
  };
}
