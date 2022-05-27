{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      vale
    ];
    shellAliases = {
      vale = "vale --config=${config.xdg.configHome}/vale/vale.ini";
    };
  };

  xdg.configFile = {
    "vale" = {
      source = ./config;
      recursive = true;
    };
  };
}
