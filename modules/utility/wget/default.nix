{ lib, pkgs, ... }:
{
  xdg.configFile."wget/config".source = config/wgetrc;
}
