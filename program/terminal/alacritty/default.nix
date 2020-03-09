{ config, lib, pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		settings = lib.attrsets.recursiveUpdate (import ./default-options.nix) {
			font.size = 8;
		};
	};
}
