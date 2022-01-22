{ pkgs, lib, ... }:
{
  xdg.configFile."ripgrep" = {
    source = ./config;
    recursive = true;
  };
}
