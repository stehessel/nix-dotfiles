{ config, lib, pkgs, ... }:
{
	xdg.configFile."alacritty/alacritty.yml".source = config/alacritty.yml;
}
