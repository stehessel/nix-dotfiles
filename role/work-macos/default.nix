{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	home.packages = with pkgs; [
		# dev
		cargo
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
		ripgrep
		tre-command
		# utility
		bandwhich
		direnv
		du-dust
		hyperfine
		just
		procs
		# pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
