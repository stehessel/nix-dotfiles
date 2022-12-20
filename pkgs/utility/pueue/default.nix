{pkgs, ...}: {
  home.packages = with pkgs; [
    pueue
  ];
}
