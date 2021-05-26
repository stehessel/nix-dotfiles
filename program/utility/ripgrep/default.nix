{ config, lib, pkgs, ... }:
{
  xdg.configFile."ripgrep" = {
    source = ./config;
    recursive = true;
  };
}
