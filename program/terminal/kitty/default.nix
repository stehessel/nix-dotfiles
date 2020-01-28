{ config, lib, pkgs, ... }:
{
	xdg.configFile."kitty/kitty.conf".source = config/kitty.conf;
}
