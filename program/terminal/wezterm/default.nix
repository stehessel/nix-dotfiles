{ pkgs, lib, ... }:
{
  xdg.configFile."wezterm" = {
    source = ./config;
    recursive = true;
  };
}
