{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/editor/kakoune
		../../program/fileviewer/lf
		../../program/fileviewer/vifm
		../../program/shell/fish
		../../program/terminal/kitty
	];

	home.file.".nixpath".source = config/nixpath;

	nixpkgs.config.allowUnfree = true;
}
