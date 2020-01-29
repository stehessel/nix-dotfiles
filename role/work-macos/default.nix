{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		bat
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
		slack-dark
		speedtest-cli
		starship
		taskwarrior
		vifm
		xsv
	];
}
