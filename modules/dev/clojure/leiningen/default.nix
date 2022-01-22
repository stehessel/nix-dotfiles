{ pkgs, lib, ... }:
{
  xdg.configFile."lein/profiles.clj".source = config/profiles.clj;
}
