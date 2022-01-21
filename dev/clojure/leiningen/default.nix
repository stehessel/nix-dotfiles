{ pkgs, lib, ... }:
{
  home.file.".lein" = {
    source = ./config;
    recursive = true;
  };
}
