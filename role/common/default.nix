{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/dev/python/flake8
		../../program/editor/kakoune
		../../program/file-manager/lf
		../../program/file-manager/vifm
		../../program/shell/fish
		../../program/shell/starship
		../../program/todo/taskwarrior
		../../program/terminal/kitty
	];

	home.file.".nixpath".source = config/nixpath;

	nixpkgs.config.allowUnfree = true;
}
