{ pkgs, lib, ... }:
{
  xdg.configFile."luaformatter/config.yaml".source = config/config.yaml;
}
