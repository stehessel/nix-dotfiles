{ pkgs, lib, ... }:
{
  xdg.configFile."restic" = {
    source = ./config;
    recursive = true;
  };
}
