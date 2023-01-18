{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      restic
    ];
  };
  xdg.configFile."restic" = {
    source = ./config;
    recursive = true;
  };
}
