{ config, lib, pkgs, ... }:
{
	home.file.".tmux.conf".source = config/tmux.conf;
}
