{ config, lib, pkgs, ... }:
{
	xdg.configFile."pip" = {
		source = ./config;
		recursive = true;
	};
}
