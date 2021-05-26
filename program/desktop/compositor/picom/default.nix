{ config, lib, pkgs, ... }:
{
  xdg.configFile."picom/picom.conf".source = config/picom.conf;
}
