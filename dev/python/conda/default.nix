{ config, lib, pkgs, ... }:
{
	home.file.".condarc".source = config/condarc;
	xdg.configFile."fish/conda.fish".source = config/conda.fish;
}
