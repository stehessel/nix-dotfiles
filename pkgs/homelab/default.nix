{pkgs, ...}: {
  imports = [
    ./managarr
    ./spire
  ];
  home.packages = with pkgs; [
    # ntfy-sh
  ];
}
