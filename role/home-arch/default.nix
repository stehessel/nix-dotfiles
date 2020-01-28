{ config, lib, pkgs, ... }:
{
	imports = [
		../common
		../../desktop/compositor/picom
		../../desktop/window-manager/qtile
		../../desktop/dunst
		../../desktop/rofi
		../../desktop/sxhkd
	];
}
