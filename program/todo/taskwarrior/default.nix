{ config, lib, pkgs, ... }:
{
  home.file.".taskrc".source = config/taskrc;
}
