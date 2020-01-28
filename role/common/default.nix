{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/editor/kakoune
		../../program/fileviewer/lf
		../../program/fileviewer/vifm
		../../program/shell/fish
		../../program/terminal/kitty
		../../program/zathura
	];

	nixpkgs.config.allowUnfree = true;
}
