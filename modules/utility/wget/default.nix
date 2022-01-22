{ pkgs, lib, ... }:
{
  xdg.configFile."wget/config".source = config/wgetrc;
}
