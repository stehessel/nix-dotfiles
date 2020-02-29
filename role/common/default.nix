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
		../../program/terminal/tmux
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
		# --- haskell ---
		stack
		# --- nix ---
		arion
		lorri
		niv
		nox
		pypi2nix
		# --- rust ---
		rustup
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
		# procs
		pueue
		speedtest-cli
		svgcleaner
		taskwarrior
		topgrade
	];

	programs.alacritty = {
		enable = true;
		settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
			font.size = 8;
		};
	};
}
