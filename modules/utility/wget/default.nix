{ config, lib, pkgs, ... }:
{
  home.sessionVariables = {
    WGETRC = "${config.xdg.configHome}/wget/config";
  };
  xdg.configFile."wget/config".source = config/wgetrc;
}
