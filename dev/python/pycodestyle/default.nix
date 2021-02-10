{ config, lib, pkgs, ... }:
{
  xdg.configFile."pycodestyle".source = config/pycodestyle;
}
