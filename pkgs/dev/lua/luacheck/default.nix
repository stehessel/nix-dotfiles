{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."luacheck/.luacheckrc".source = config/luacheckrc;
}
