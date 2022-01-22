{ pkgs, lib, ... }:
{
  xdg.configFile."dunst/dunstrc".source = config/dunstrc;
}
