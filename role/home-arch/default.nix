{ config, lib, pkgs, ... }:
{
	imports = [
		../common
		../../program/desktop/compositor/picom
		../../program/desktop/window-manager/qtile
		../../program/desktop/dunst
		../../program/desktop/mime-apps
		../../program/desktop/rofi
		../../program/desktop/sxhkd
		../../program/file-viewer/sxiv
		../../program/file-viewer/zathura
	];

	home.file.".profile".source = config/profile;
}
