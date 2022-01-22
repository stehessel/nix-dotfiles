{ pkgs, lib, ... }:
{
  home.file.".condarc".source = config/condarc;
}
