{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		bat
		betterlockscreeen
		exa
		fd
		fish
		fzf
		highlight
		kak-lsp
		kakoune
		kitty
		lf
		ripgrep
		starship
		vifm
		xsv
	];
}
