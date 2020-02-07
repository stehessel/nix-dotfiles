{ config, lib, pkgs, ... }:
{
	xdg.configFile."nix" = {
		source = ./config;
		recursive = true;
	};
}
