{ config, lib, pkgs, ... }:
{
	xdg.configFile."fish" = {
		source = ./config;
		recursive = true;
	};
}
