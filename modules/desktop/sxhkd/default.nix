{ pkgs, lib, ... }:
{
  xdg.configFile."sxhkd/sxhkdrc".source = config/sxhkdrc;
}
