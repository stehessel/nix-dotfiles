{ pkgs, lib, ... }:
{
  xdg.configFile."zathura/zathurarc".source = config/zathurarc;
}
