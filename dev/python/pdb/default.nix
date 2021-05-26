{ config, lib, pkgs, ... }:
{
  home.file.".pdbrc".source = config/pdbrc;
  home.file.".pdbrc.py".source = config/pdbrc.py;
}
