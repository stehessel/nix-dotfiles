{ config, lib, pkgs, ... }:
{
	xdg.configFile.".isort.cfg".source = config/isort.cfg;
}
