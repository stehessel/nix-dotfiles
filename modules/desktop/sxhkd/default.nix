{ lib, pkgs, ... }:
{
  xdg.configFile."sxhkd/sxhkdrc".source = config/sxhkdrc;
}
