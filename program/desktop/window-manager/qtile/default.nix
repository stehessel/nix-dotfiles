{ config, lib, pkgs, ... }:
{
  xdg.configFile."qtile/config.py".source = config/config.py;
}
