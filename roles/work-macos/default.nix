{ pkgs, lib, ... }:
{
  imports = [
    ../common
    ../../modules/terminal/wezterm
  ];

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/macos/fish_plugins;

  home.packages = with pkgs; [
    # --- container ---
    podman
    qemu
    # --- editor ---
    neovim
    # --- latex ---
    # texlive.combined.scheme-full
    # tectonic
    # --- terminal ---
    kitty
    # wezterm
    # --- window manager ---
    yabai
  ];

  programs.alacritty = {
    settings = lib.attrsets.recursiveUpdate (import ../../modules/terminal/alacritty/default-options.nix) {
      font.size = 18;
      font.use_thin_strokes = true;
      window.decorations = "buttonless";
    };
  };
}
