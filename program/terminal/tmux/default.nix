{ config, lib, pkgs, ... }:
{
	xdg.configFile."tmux" = {
		source = ./config;
		recursive = true;
	};
}
