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
		../../program/utility/topgrade
	];

	nixpkgs.config.allowUnfree = true;
}
