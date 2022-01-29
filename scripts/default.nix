{ lib, pkgs, ... }:
{
  home.file.".local/bin" = {
    source = ./config;
    recursive = true;
  };
}
