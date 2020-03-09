{ config, lib, pkgs, ... }:
{
	programs.git = import ./default-options.nix;
}
