{ pkgs, lib, ... }:
{
  xdg.configFile.".isort.cfg".source = config/isort.cfg;
}
