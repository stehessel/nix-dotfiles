{ config, lib, pkgs, ... }:
{
	xdg.configFile."bpswm/bspwmrc".source = config/bspwmrc;
}
