{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ntfy-sh
    ];
  };
}
