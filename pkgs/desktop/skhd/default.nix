{ lib, pkgs, ... }:
{
  xdg.configFile."skhd/skhdrc".source = config/skhdrc;
}
