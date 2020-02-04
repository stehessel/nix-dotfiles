{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		# dev
		cargo
		ccls
		editorconfig-core-c
		fira-code
		kakoune
		# pier
		rustc
		tig
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
		exa
		fd
		fzf
		highlight
		kitty
		neofetch
		ripgrep
		tmux
		tre-command
		# utility
		bandwhich
		direnv
		du-dust
		htop
		hyperfine
		jrnl
		just
		# procs
		# pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
