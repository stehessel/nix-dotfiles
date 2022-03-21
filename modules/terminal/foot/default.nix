{ lib, pkgs, ... }:
{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        app-id = "foot";
        dpi-aware = "yes";
        font = "FiraCode Nerd Font:size=8";
        term = "screen-256color";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
