{ config, lib, pkgs, ... }:
{
	xdg.configFile."vifm" = {
		source = ./config;
		recursive = true;
	};
}
