{ pkgs, lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = import ./default-options.nix;
  };
}
