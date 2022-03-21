{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../modules/desktop/dunst
    ../../modules/desktop/mime-apps
    ../../modules/desktop/rofi
    ../../modules/desktop/sxhkd
    ../../modules/desktop/waybar
    ../../modules/desktop/window-manager/river
    ../../modules/file-viewer/sxiv
    ../../modules/file-viewer/zathura
    ../../modules/package-manager/nix
    ../../modules/terminal/foot
  ];

  home = {
    sessionVariables = {
      XKB_DEFAULT_OPTIONS = "caps:escape";
    };
    packages = with pkgs; [
      # --- bookmarks ---
      buku
      # --- browsers ---
      brave
      # --- clipboard ---
      xclip
      # --- desktop ---
      libnotify
      rofi
      wl-clipboard
      waybar
      # --- dev ---
      gcc
      zig
      # --- file viewer ---
      glow
      # --- nix ---
      nixUnstable
      # --- terminals ---
      alacritty
      foot
      # --- window manager ---
      bemenu
      foot
      mako
      river
      swayidle
      swaylock
      wl-clipboard
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.targets = {
    tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };
  services = {
    dunst = {
      enable = true;
      waylandDisplay = "wayland-1";
    };

    sxhkd = {
      enable = true;
      extraOptions = [ "-c ~/.config/sxhkd/sxhkdrc" ];
    };

    syncthing = {
      enable = true;
      tray = {
        enable = true;
        command = "syncthingtray --wait";
      };
    };
  };

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/linux/fish_plugins;
}
