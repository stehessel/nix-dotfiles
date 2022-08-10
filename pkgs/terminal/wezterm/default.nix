{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      wezterm
    ];
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
  xdg.configFile."wezterm" = {
    source = ./config;
    recursive = true;
  };
}
