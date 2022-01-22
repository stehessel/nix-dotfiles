{ pkgs, lib, ... }:
{
  programs.git = import ./default-options.nix;
}
