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
		universal-ctags
		editorconfig-core-c
		gdb
		jq
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
		# --- font ---
		fira-code
		font-awesome
		hack-font
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
		alacritty
		kitty
		# --- terminal tools ---
		bat
		broot
		exa
		fd
		fzf
		highlight
		neofetch
		ripgrep
		skim
		tmux
		tre-command
		# --- utility ---
		bandwhich
		direnv
		du-dust
		file
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

	programs.alacritty = {
		enable = true;
		settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
			font.size = 15;
			font.use_thin_strokes = true;
		};
	};
}
