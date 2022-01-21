{ pkgs, lib, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
{
  imports = [
    ../common
    ../../program/desktop/dunst
    ../../program/desktop/mime-apps
    ../../program/desktop/rofi
    ../../program/desktop/sxhkd
    ../../program/desktop/waybar
    ../../program/desktop/window-manager/river
    ../../program/file-viewer/sxiv
    ../../program/file-viewer/zathura
    ../../program/terminal/foot
  ];

  home.packages = with pkgs; [
    # --- bookmarks ---
    buku
    # --- clipboard ---
    xclip
    # --- desktop ---
    wl-clipboard
    # --- file viewer ---
    glow
    # --- lua ---
    sumneko-lua-language-server
    # --- shell ---
    bashInteractive
    fish
  ];

  programs = {
    go = {
      enable = true;
    };
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

  xdg.configFile."fish/fish_plugins".source = ../../program/shell/fish/linux/fish_plugins;
  home.file.".profile".source = config/profile;
}
