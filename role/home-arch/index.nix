{ config, lib, pkgs, ... }:

{
	imports = [
		../common/index.nix
		../../desktop/compositor/picom
		../../desktop/window-manager/qtile
		../../desktop/dunst
		../../desktop/rofi
		../../desktop/sxhkd
	];
}
