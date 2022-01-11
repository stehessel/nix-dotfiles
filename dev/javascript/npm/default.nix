{ config, lib, pkgs, ... }:
{
  xdg.configFile."npm/config".source = config/npmrc;
}
