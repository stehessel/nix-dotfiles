{ lib, pkgs, ... }:
{
  xdg.configFile."yabai/yabairc".source = config/yabairc;
}
