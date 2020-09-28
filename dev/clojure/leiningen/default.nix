{ config, lib, pkgs, ... }:
{
	home.file.".lein" = {
		source = ./config;
		recursive = true;
	};
}
