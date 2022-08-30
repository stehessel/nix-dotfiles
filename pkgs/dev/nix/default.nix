{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # cachix
      nix-prefetch-github
      nix-update
      nixpkgs-fmt
      rnix-lsp
      statix
    ];
  };
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
