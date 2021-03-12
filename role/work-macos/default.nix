{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
{
  imports = [
    ../common
    # ../../dev/python/pip
    ../../program/editor/vimspector
  ];

  xdg.configFile."nix/nix-single-user.fish".source = config/nix-single-user.fish;
  xdg.configFile."fish/fish_plugins".source = ../../program/shell/fish/macos/fish_plugins;

  home.packages = with pkgs; [
    # --- terminal ---
    kitty
    # --- latex ---
    texlive.combined.scheme-full
    tectonic
  ];

  programs.alacritty = {
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-options.nix) {
      font.size = 16;
      font.use_thin_strokes = true;
      window.decorations = "buttonless";
    };
  };
}
