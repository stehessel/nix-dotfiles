{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
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

    home.packages = with pkgs; [
        # --- bookmarks ---
        buku
        # --- editor ---
        # kakoune
        # neovim
        # --- file viewer ---
		glow
	];

	xdg.configFile."nix/nix-daemon.fish".source = config/nix-daemon.fish;
	xdg.configFile."fish/fish_plugins".source = ../../program/shell/fish/linux/fish_plugins;
	home.file.".profile".source = config/profile;
}
