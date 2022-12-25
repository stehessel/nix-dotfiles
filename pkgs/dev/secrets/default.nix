{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      age
      sops
      vals
    ];
  };
}
