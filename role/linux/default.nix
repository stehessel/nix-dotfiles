{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
{
  imports = [
    ../common
    ../../program/desktop/compositor/picom
    ../../program/desktop/window-manager/qtile
    ../../program/desktop/dunst
    ../../program/desktop/mime-apps
    ../../program/desktop/rofi
    ../../program/desktop/sxhkd
    ../../program/file-viewer/sxiv
    ../../program/file-viewer/zathura
  ];

  home.packages = with pkgs; [
    # --- bookmarks ---
    buku
    # --- file viewer ---
    glow
  ];

  systemd.user.targets = {
    tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };
  services = {
    sxhkd = {
      enable = true;
      extraOptions = [ "-c ~/.config/sxhkd/sxhkdrc" ];
    };

    syncthing = {
      enable = true;
      tray = { enable = true; };
    };
  };

  xdg.configFile."fish/fish_plugins".source = ../../program/shell/fish/linux/fish_plugins;
  home.file.".profile".source = config/profile;
}
