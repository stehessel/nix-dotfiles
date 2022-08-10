{ config, lib, pkgs, ... }:
{
  home = {
    packages = [
      pkgs.ripgrep
    ];
    sessionVariables = {
      RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/rc";
    };
  };
  xdg.configFile."ripgrep" = {
    source = ./config;
    recursive = true;
  };
}
