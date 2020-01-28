{ config, lib, pkgs, ... }:

{
	imports = [
		../common/index.nix
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
