{pkgs, ...}: {
  imports = [
    ../../pkgs/desktop/skhd
    ../../pkgs/desktop/window-manager/yabai
    ../../pkgs/terminal/kitty
    ../../pkgs/virtualization/colima
    ../common
    ./secrets
  ];

  xdg.configFile."fish/fish_plugins".source = ../../pkgs/shell/fish/macos/fish_plugins;

  home = {
    packages = with pkgs; [
      # --- containers ---
      docker
      docker-compose
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
