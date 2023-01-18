{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # age
      bitwarden-cli
      sops
      vals
    ];
  };
}
