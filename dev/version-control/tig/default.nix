{ config, lib, pkgs, ... }:
{
	xdg.configFile = {
		"tig" = {
			source = ./config;
			recursive = true;
		};
	};
}
