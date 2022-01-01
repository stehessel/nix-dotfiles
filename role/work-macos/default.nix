{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
{
  imports = [
    ../common
    # ../../dev/python/pip
    ../../program/editor/vimspector
  ];

  xdg.configFile."fish/fish_plugins".source = ../../program/shell/fish/macos/fish_plugins;

  home.packages = with pkgs; [
    # --- editor ---
    neovim
    # --- latex ---
    # texlive.combined.scheme-full
    # tectonic
    # --- lua ---
    # sumneko-lua-language-server
    # --- terminal ---
    kitty
  ];

  programs.alacritty = {
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-options.nix) {
      font.size = 18;
      font.use_thin_strokes = true;
      window.decorations = "buttonless";
    };
  };
}
