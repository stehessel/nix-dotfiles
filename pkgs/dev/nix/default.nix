{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      alejandra
      cachix
      deadnix
      nix-prefetch-github
      nix-update
      nixpkgs-fmt
      nixpkgs-review
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
