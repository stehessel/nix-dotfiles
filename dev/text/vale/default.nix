{ config, lib, pkgs, ... }:
{
  xdg.configFile = {
    "vale" = {
      source = ./config;
      recursive = true;
    };
  };
}
