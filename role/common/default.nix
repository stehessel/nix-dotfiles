{ config, lib, pkgs, ... }:
{
	imports = [
		../../program/dev/python/flake8
		../../program/dev/version-control/tig
		../../program/editor/kakoune
		../../program/file-manager/lf
		../../program/file-manager/vifm
		../../program/shell/fish
		../../program/shell/starship
		../../program/terminal/kitty
		../../program/todo/taskwarrior
		# ../../program/utility/pueue
		../../program/utility/topgrade
	];

	xdg.configFile."nix/nix-daemon.fish".source = config/nix-daemon.fish;

	nixpkgs.config.allowUnfree = true;
}
