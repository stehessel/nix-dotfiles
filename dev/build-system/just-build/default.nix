{ config, lib, pkgs, ... }:
{
	home.file."just-build" = {
		source = ./config;
		recursive = true;
	};
}
