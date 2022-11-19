{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."containers" = {
    source = ./config;
    recursive = true;
  };
}
