{ pkgs, lib, ... }:
{
  xdg.configFile."nix" = {
    source = ./config;
    recursive = true;
  };
}
