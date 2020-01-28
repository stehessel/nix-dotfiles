{ config, lib, pkgs, ... }:
{
	imports = [
		../common
		../../desktop/compositor/picom
		../../desktop/window-manager/qtile
		../../desktop/dunst
		../../desktop/mime-apps
		../../desktop/rofi
		../../desktop/sxhkd
		../../program/sxiv
		../../program/zathura
	];
}
