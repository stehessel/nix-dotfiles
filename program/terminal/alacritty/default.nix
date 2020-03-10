{ config, lib, pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		settings = import ./default-options.nix;
	};
}
