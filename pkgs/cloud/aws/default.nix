{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      aws-vault
      # awscli2
      chamber
      cw
    ];
  };
}
