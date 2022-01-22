{ pkgs, lib, ... }:
{
  xdg.configFile."river/init".source = config/init;
}
