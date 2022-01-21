{ pkgs, lib, ... }:
{
  xdg.configFile = {
    "vale" = {
      source = ./config;
      recursive = true;
    };
  };
}
