{ pkgs, lib, ... }:
{
  xdg.configFile."mypy/config".source = config/config;
}
