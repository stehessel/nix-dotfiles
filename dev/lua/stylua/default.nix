{ pkgs, lib, ... }:
{
  xdg.configFile."stylua/stylua.toml".source = config/stylua.toml;
}
