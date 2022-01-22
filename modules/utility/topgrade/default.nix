{ pkgs, lib, ... }:
{
  xdg.configFile."topgrade.toml".source = config/topgrade.toml;
}
