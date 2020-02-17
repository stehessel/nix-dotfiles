{ config, lib, pkgs, ... }:
{
	home.file.".magic".source = config/magic;
	home.file.".magic.mgc".source = config/magic.mgc;
}
