{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/dev/python/flake8
		../../program/editor/kakoune
		../../program/file-manager/lf
		../../program/file-managervifm
		../../program/shell/fish
		../../program/terminal/kitty
	];

	home.file.".nixpath".source = config/nixpath;

	nixpkgs.config.allowUnfree = true;
}
