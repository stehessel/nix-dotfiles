{ config, lib, pkgs, ... }:
{
	xdg.configFile."tig/config".source = config/tigrc;
}
