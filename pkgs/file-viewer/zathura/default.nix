{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."zathura/zathurarc".source = config/zathurarc;
}
