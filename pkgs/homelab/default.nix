{pkgs, ...}: {
  imports = [
    ./managarr
  ];
  home = {
    packages = with pkgs; [
      ntfy-sh
    ];
  };
}
