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
		gdb
		jq
		fira-code
		kakoune
		#pier
		pypi2nix
		rustc
		tig
		tokei
		xsv
		# file-manager
		lf
		vifm
		# file-viewer
		glow
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
		skim
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
		nox
		#procs
		#pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
