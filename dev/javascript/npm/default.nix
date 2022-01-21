{ pkgs, lib, ... }:
{
  xdg.configFile."npm/config".source = config/npmrc;
}
