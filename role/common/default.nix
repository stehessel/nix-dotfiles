{ config, lib, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	imports = [
		../../program/dev/build-system/just-build
		../../program/dev/haskell/hie
		../../program/dev/haskell/stack
		../../program/dev/javascript/npm
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
		../../program/editor/coc
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
		# clang
        gdb
		# --- dev ---
		editorconfig-core-c
		jq
		tig
		tokei
		universal-ctags
		xsv
		# --- editor ---
        neovim-remote
        # --- docker ---
        # docker-sync
        unison
        fswatch
		# --- file manager ---
		lf
		vifm
		# --- file search ---
		broot
		fd
		ripgrep
        tre-command
        # --- file transfer ---
        rsync
		# --- file viewer ---
		pandoc
		# --- font ---
		fira-code
		font-awesome
		hack-font
		# nerdfonts
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
        # --- javascript ---
        nodejs-13_x
        yarn
        # --- launcher ---
		entr
		just
		pueue
		# --- network ---
		bandwhich
		speedtest-cli
		# --- nix ---
		arion
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
        # --- ruby ---
        # ruby
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
		ansible
		direnv
		du-dust
		file
		gitAndTools.diff-so-fancy
		hyperfine
		jrnl
		neofetch
		svgcleaner
        topgrade
        wget
	];
}
