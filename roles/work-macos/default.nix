{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../modules/desktop/skhd
    ../../modules/desktop/window-manager/yabai
    ../../modules/terminal/kitty
    # ../../modules/terminal/wezterm
    ../../modules/virtualization/colima
  ];

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/macos/fish_plugins;

  home = {
    packages = with pkgs; [
      # --- containers ---
      docker
      docker-compose
      # --- latex ---
      # texlive.combined.scheme-full
      # tectonic
      # --- text ---
      gnused
      # --- window manager ---
      # yabai
    ];

    sessionVariables = {
      XDG_RUNTIME_DIR = "$TMPDIR";
    };

    # Needed for nvim-spectre on macOS
    shellAliases = {
      gsed = "sed";
    };
  };
}
