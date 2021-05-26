{ config, lib, pkgs, ... }:
{
  home.file.".bashrc".source = config/bashrc;
}
