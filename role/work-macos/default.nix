{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		fish
		kak-lsp
		kakoune
		kitty
		lf
		vifm
	];
}
