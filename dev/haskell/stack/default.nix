{ config, lib, pkgs, ... }:
{
	home.file.".stack" = {
		source = ./config;
		recursive = true;
	};
}
