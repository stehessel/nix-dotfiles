{ pkgs, lib, ... }:
{
  xdg.configFile."luacheck/.luacheckrc".source = config/luacheckrc;
}
