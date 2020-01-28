{ config, lib, pkgs, ... }:
{
	xdg.dataFile = {
		"applications" = {
			source = ./config;
			recursive = true;
		};
	};
}
