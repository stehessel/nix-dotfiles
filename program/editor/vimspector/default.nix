{ config, lib, pkgs, ... }:
{
	home.file."git/.vimspector.json".source = config/raq.json;
}
