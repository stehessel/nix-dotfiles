{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		# dev
		cargo
		editorconfig-core-c
		fira-code
		kak-lsp
		kakoune
		#pier
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
		bash
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
		#procs
		#pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
