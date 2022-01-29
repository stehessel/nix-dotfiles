{ lib, pkgs, ... }:
{
  xdg.configFile."rofi/config".source = config/config;
}
