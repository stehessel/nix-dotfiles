{ config, lib, pkgs, ... }:
{
	xdg.configFile."mypy/config".source = config/config;
}
