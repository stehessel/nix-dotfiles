{ pkgs, lib, ... }:
{
  xdg.configFile."foot" = {
    source = ./config;
    recursive = true;
  };
}
