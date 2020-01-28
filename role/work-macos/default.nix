{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		fish
		kakoune
		kitty
		sxiv
		vifm
		zathura
	];
}
