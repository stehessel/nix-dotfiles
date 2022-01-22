{ pkgs, lib, ... }:
{
  xdg.configFile."bobthefish/config.fish".source = config/config.fish;
}
