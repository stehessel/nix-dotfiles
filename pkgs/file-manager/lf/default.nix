{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."lf" = {
    source = ./config;
    recursive = true;
  };
  home = {
    packages = with pkgs; [
      lf
    ];
  };
}
