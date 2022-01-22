{ pkgs, lib, ... }:
{
  xdg.configFile."pycodestyle".source = config/pycodestyle;
}
