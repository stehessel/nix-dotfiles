{ config, lib, pkgs, ... }:
{
	imports = [ ../kak-lsp/default.nix ];

	xdg.configFile = {
		"kak/kakrc".source = config/kakrc;
		"kak/colors" = {
			source = ./config/colors;
			recursive = true;
		};
	};
}
