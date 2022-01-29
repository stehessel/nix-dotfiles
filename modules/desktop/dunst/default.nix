{ lib, pkgs, ... }:
{
  xdg.configFile."dunst/dunstrc".source = config/dunstrc;
}
