{ config, pkgs, lib, ... }:
{
  home = {
    sessionPath = [
      "${config.xdg.configHome}/cargo/bin"
    ];
    sessionVariables = {
      CARGO_HOME = "${config.xdg.configHome}/cargo";
    };
  };

  xdg.configFile."cargo" = {
    source = ./config;
    recursive = true;
  };
}
