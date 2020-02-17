{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/dev/build-system/just-build
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
		../../program/terminal/alacritty
		../../program/terminal/kitty
		../../program/terminal/tmux
		../../program/todo/taskwarrior
		../../program/utility/broot
		../../program/utility/file
		# ../../program/utility/pueue
		../../program/utility/topgrade
	];

	nixpkgs.config.allowUnfree = true;
}
