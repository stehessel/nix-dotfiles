{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		firefox
		fish
		kak-lsp
		kakoune
		kitty
		lf
		vifm
	];
}
