{ pkgs, lib, ... }:
{
  home.file.".bashrc".source = config/bashrc;
}
