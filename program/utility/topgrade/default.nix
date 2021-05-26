{ config, lib, pkgs, ... }:
{
  xdg.configFile."topgrade.toml".source = config/topgrade.toml;
}
