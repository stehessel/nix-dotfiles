{ config, lib, pkgs, ... }:
{
	home.file = {
		source = ./config;
		recursive = true;
	};
}
