{ config, lib, pkgs, ... }:
{
	xdg.configFile."luaformatter/config.yaml".source = config/config.yaml;
}
