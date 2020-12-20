{ config, lib, pkgs, ... }:
{
  xdg.configFile."vale".source = config/vale.ini;
}
