{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."stylua/stylua.toml".source = config/stylua.toml;
}
