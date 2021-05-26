{ config, lib, pkgs, ... }:
{
  xdg.configFile."kak-lsp/kak-lsp.toml".source = config/kak-lsp.toml;
}
