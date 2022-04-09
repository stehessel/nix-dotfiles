{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../modules/desktop/dunst
    ../../modules/desktop/mime-apps
    ../../modules/desktop/rofi
    ../../modules/desktop/waybar
    ../../modules/desktop/window-manager/river
    ../../modules/file-viewer/sxiv
    ../../modules/file-viewer/zathura
    ../../modules/networking/syncthing
    ../../modules/terminal/foot
  ];

  home =
    let
      python-packages = ps: [ ps.pynvim ];
      neovim-python = pkgs.python3.withPackages python-packages;
    in
    {
      packages = with pkgs; [
        # --- bookmarks ---
        buku
        # --- browsers ---
        brave
        # --- desktop ---
        bemenu
        cliphist
        libnotify
        mako
        rofi
        syncthingtray
        wl-clipboard
        wofi
        # --- dev ---
        gcc
        gnumake
        zig
        # --- file viewer ---
        glow
        # --- icons ---
        gnome.adwaita-icon-theme
        # --- neovim ---
        neovim-python
        # --- networking ---
        networkmanagerapplet
        # --- window manager ---
        river
        swaybg
        swayidle
        swaylock
      ];
    };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.targets = {
    hm-graphical-session = {
      Unit = {
        Description = "Home Manager Session";
        Requires = [ "graphical-session-pre.target" ];
        BindsTo = [ "graphical-session.target" "tray.target" ];
      };
    };

    tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/linux/fish_plugins;
}
