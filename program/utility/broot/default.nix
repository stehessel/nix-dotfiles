{ config, lib, pkgs, ... }:
{
	xdg.configFile."broot" = {
		source = ./config;
		recursive = true;
	};
}
