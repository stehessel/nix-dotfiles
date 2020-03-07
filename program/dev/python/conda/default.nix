{ config, lib, pkgs, ... }:
{
	home.file.".condarc".source = config/condarc;
}
