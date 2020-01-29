{ config, lib, pkgs, ... }:
{
	xdg.configFile."starship.toml".source = config/starship.toml;
}
