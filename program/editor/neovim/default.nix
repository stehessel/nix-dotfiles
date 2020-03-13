{ config, lib, pkgs, ... }:
{
	xdg.configFile."nvim" = {
		source = ./config;
		recursive = true;
	};
}
