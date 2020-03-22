{ config, lib, pkgs, ... }:
{
	xdg.configFile."nvim/coc-settings.json".source = config/coc-settings.json;
}
