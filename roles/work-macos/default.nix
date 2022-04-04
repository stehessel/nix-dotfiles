{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../modules/desktop/skhd
    ../../modules/desktop/window-manager/yabai
    ../../modules/terminal/wezterm
  ];

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/macos/fish_plugins;

  home = {
    packages = with pkgs; [
      # --- containers ---
      docker
      docker-compose_2
      # --- latex ---
      # texlive.combined.scheme-full
      # tectonic
      # --- terminal ---
      kitty
      # wezterm
      # --- text ---
      gnused
      # --- virtualization ---
      colima
      # --- window manager ---
      # yabai
    ];

    sessionVariables = {
      XDG_RUNTIME_DIR = "$TMPDIR";
    };
  };
}
