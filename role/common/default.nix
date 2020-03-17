{ config, lib, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	# nixpkgs.overlays = [
	# 	(self: super: {
	# 		python37 = super.python37.override {
	# 			packageOverrides = python-self: python-super: {
	# 				psutils = python-super.psutils.overrideAttrs (oldAttrs: {
	# 					doCheck = false;
	# 				});
	# 			};
	# 		};
	# 	}) ];

	imports = [
		../../program/dev/build-system/just-build
		../../program/dev/haskell/hie
		../../program/dev/haskell/stack
		../../program/dev/python/conda
		../../program/dev/python/flake8
		../../program/dev/python/isort
		../../program/dev/python/mypy
		# ../../program/dev/python/packages
		../../program/dev/python/pycodestyle
		../../program/dev/version-control/git
		../../program/dev/version-control/tig
		../../program/editor/kakoune
		../../program/editor/neovim
		../../program/file-manager/lf
		../../program/file-manager/vifm
		# ../../program/package-manager/nix
		../../program/shell/bash
		../../program/shell/bobthefish
		../../program/shell/fish
		../../program/shell/starship
		../../program/terminal/alacritty
		../../program/terminal/kitty
		../../program/terminal/screen
		../../program/terminal/tmux
		../../program/todo/tasklite
		../../program/todo/taskwarrior
		../../program/utility/broot
		../../program/utility/file
		# ../../program/utility/pueue
		../../program/utility/ripgrep
		../../program/utility/topgrade
	];

	# home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
	# home.sessionVariables = {
	# 	LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
	# };

	home.packages = with pkgs; [
		# --- cpp ---
		ccls
		gdb
		# --- dev ---
		editorconfig-core-c
		jq
		gcc
		tig
		tokei
		universal-ctags
		xsv
		# --- editor ---
		# kakoune
		# neovim
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
		# cabal-install
		ghc
		stack
		# --- highlighters ---
		bat
		exa
		highlight
		# --- launcher ---
		entr
		just
		pueue
		# --- network ---
		bandwhich
		speedtest-cli
		# --- nix ---
		# arion
		cachix
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
		bash_5
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
		# ansible
		direnv
		du-dust
		file
		gitAndTools.diff-so-fancy
		hyperfine
		jrnl
		neofetch
		svgcleaner
		topgrade
	];
}
