{ pkgs, lib, ... }:
{
  home.file.".local/bin" = {
    source = ./config;
    recursive = true;
  };
}
