{ lib, pkgs, ... }:
{
  xdg.configFile."river/init".source = config/init;
}
