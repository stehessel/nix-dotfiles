{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      cachix
      deadnix
      nil
      nix-info
      nix-output-monitor
      nix-prefetch-github
      nix-update
      nixd
      nixpkgs-fmt
      nixpkgs-review
      nurl
      statix
      # vulnix
    ];
  };
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
    };
  };
}
