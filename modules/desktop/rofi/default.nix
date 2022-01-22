{ pkgs, lib, ... }:
{
  xdg.configFile."rofi/config".source = config/config;
}
