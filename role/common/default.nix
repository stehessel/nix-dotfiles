{ config, lib, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	imports = [
		../../program/dev/build-system/just-build
		../../program/dev/haskell/hie
		../../program/dev/haskell/stack
		../../program/dev/python/conda
		../../program/dev/python/flake8
		../../program/dev/python/isort
		../../program/dev/python/mypy
		../../program/dev/python/pycodestyle
		../../program/dev/python/python
		../../program/dev/version-control/tig
		../../program/editor/kakoune
		../../program/file-manager/lf
		../../program/file-manager/vifm
		# ../../program/package-manager/nix
		../../program/shell/bash
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
		ghc
		# stack
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
		gitAndTools.diff-so-fancy
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
	
	programs.git = {
		enable = true;
		ignores = [
			"*~"
			"*.swp"
			"__pycache__"
		];
		extraConfig = {
			core = {
				pager = "diff-so-fancy | less --tabs=4 -RFX";
			};
			color = {
				ui = "true";
				diff-highlight = {
					oldNormal    = "red bold";
					oldHighlight = "red bold 52";
					newNormal    = "green bold";
					newHighlight = "green bold 22";
				};
				diff = {
					meta = "11";
					frag = "magenta bold";
					commit = "yellow bold";
					old = "red bold";
					new = "green bold";
					whitespace = "red reverse";
				};
			};
		};
	};
}
