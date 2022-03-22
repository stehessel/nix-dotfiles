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
    ../../modules/terminal/foot
  ];

  home = {
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
      zig
      # --- file viewer ---
      glow
      # --- networking ---
      networkmanagerapplet
      # --- nix ---
      nixUnstable
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

    syncthing = {
      enable = true;
      tray = {
        enable = true;
        command = "syncthingtray --wait";
        package = pkgs.syncthingtray;
      };
    };
  };

  xdg.configFile."fish/fish_plugins".source = ../../modules/shell/fish/linux/fish_plugins;
}
