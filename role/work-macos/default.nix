{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	xdg.configFile."nix/nix-single-user.fish".source = config/nix-single-user.fish;

	home.packages = with pkgs; [
		# --- dev ---
		cargo
		ccls
		editorconfig-core-c
		gdb
		jq
		fira-code
		kakoune
		rustc
		tig
		tokei
		xsv
		# --- file-manager ---
		lf
		vifm
		# --- file-viewer ---
		glow
		pandoc
		# --- nix ---
		arion
		lorri
		niv
		nox
		pypi2nix
		# --- shell ---
		dash
		fish
		starship
		# --- terminal ---
		bat
		broot
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
		# --- utility ---
		bandwhich
		direnv
		du-dust
		htop
		hyperfine
		jrnl
		just
		#procs
		pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];
}
