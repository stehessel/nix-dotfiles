{ config, lib, pkgs, ... }:
{
	home.file."git/raq/.vimspector.json".source = config/raq.json;
}
