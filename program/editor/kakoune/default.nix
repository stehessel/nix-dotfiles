{ config, lib, pkgs, ... }:
{
  imports = [ ../kak-lsp ];

  xdg.configFile = {
    "kak/kakrc".source = config/kakrc;
    "kak/colors" = {
      source = config/colors;
      recursive = true;
    };
  };
}
