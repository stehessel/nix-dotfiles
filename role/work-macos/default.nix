{ config, lib, pkgs, ... }:
{
	imports = [
		../common
	];

	xdg.configFile."nix/nix-single-user.fish".source = config/nix-single-user.fish;
	xdg.configFile."fish/fishfile".source = ../../program/shell/fish/macos/fishfile;

	home.packages = with pkgs; [
		# --- editor ---
        kakoune
        neovim
		# --- terminal ---
		alacritty
		kitty
	];

	programs.alacritty = {
		settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-options.nix) {
			font.size = 14;
			font.use_thin_strokes = true;
			window.decorations = "buttonless";
		};
	};
}
