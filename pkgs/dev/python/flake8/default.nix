{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."flake8".source = config/flake8;
}
