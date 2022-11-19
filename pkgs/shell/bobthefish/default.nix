{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."bobthefish/config.fish".source = config/config.fish;
}
