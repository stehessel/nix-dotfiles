{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		# dev
		fira-code
		kak-lsp
		kakoune
		tokei
		xsv
		# file-manager
		lf
		vifm
		# shell
		dash
		fish
		starship
		# terminal
		bat
		du-dust
		exa
		fd
		fzf
		highlight
		kitty
		ripgrep
		# utility
		bandwhich
		just
		procs
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
