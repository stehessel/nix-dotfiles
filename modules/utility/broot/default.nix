{ pkgs, lib, ... }:
{
  home.file."Library/Preferences/org.dystroy.broot/conf.toml".source = config/conf.toml;
}