{ pkgs, lib, ... }:
{
  xdg.configFile."exec/key-handler".source = config/exec/key-handler;
}
