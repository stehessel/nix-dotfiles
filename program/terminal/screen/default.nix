{ config, lib, pkgs, ... }:
{
	home.file.".screenrc".source = config/screenrc;
}
