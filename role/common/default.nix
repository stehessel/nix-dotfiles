{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/dev/build-system/just-build
		../../program/dev/haskell/stack
		../../program/dev/python/flake8
		../../program/dev/python/pycodestyle
		../../program/dev/version-control/tig
		../../program/editor/kakoune
		../../program/file-manager/lf
		../../program/file-manager/vifm
		../../program/package-manager/nix
		../../program/shell/bobthefish
		../../program/shell/fish
		../../program/shell/starship
		# ../../program/terminal/alacritty
		../../program/terminal/kitty
		../../program/terminal/screen
		../../program/terminal/tmux
		../../program/todo/tasklite
		../../program/todo/taskwarrior
		../../program/utility/broot
		../../program/utility/file
		# ../../program/utility/pueue
		../../program/utility/topgrade
	];

	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		# --- cpp ---
		ccls
		gdb
		# --- dev ---
		editorconfig-core-c
		jq
		kakoune
		tig
		tokei
		universal-ctags
		xsv
		# --- file manager ---
		lf
		vifm
		# --- file search ---
		broot
		fd
		ripgrep
		tre-command
		# --- file viewer ---
		glow
		pandoc
		# --- font ---
		fira-code
		font-awesome
		hack-font
		# --- fuzzy search ---
		fzf
		skim
		# --- haskell ---
		cabal-install
		stack
		# --- highlighters ---
		bat
		exa
		highlight
		# --- launcher ---
		just
		pueue
		# --- network ---
		bandwhich
		speedtest-cli
		# --- nix ---
		arion
		lorri
		niv
		nox
		pypi2nix
		# --- process manager ---
		htop
		# procs
		# --- rust ---
		rustup
		# --- shell ---
		dash
		fish
		starship
		# --- todo manager ---
		taskwarrior
		# --- terminal multiplexers ---
		byobu
		screen
		tmux
		# --- utility ---
		direnv
		du-dust
		file
		hyperfine
		jrnl
		neofetch
		svgcleaner
		topgrade
	];

	programs.alacritty = {
		enable = true;
		settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty) {
			font.size = 8;
		};
	};
}
