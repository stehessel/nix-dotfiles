{ config, lib, pkgs, ... }:
{
	xdg.configFile."efm-langserver/config.yaml".source = config/config.yaml;
}
