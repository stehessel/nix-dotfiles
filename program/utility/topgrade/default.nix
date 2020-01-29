{ config, lib, pkgs, ... }:
{
	xdg.configFile."topgrade.toml" = config/topgrade.toml;
}
