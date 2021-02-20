{ config, lib, pkgs, ... }:
{
	xdg.configFile."cargo" = {
		source = ./config;
		recursive = true;
	};
}
