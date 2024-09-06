{pkgs, ...}: {
  imports = [
    ../../pkgs/desktop/dunst
    ../../pkgs/desktop/mime-apps
    ../../pkgs/desktop/rofi
    ../../pkgs/desktop/wayland
    ../../pkgs/file-viewer/sxiv
    ../../pkgs/file-viewer/zathura
    ../../pkgs/networking/syncthing
    ../../pkgs/terminal/foot
    ../common
    ./secrets
  ];

  home = {
    packages = with pkgs; [
      # --- bookmarks ---
      buku
      # --- desktop ---
      bemenu
      cliphist
      libnotify
      mako
      rofi
      slurp
      syncthingtray
      wl-clipboard
      wofi
      # --- dev ---
      gcc
      gnumake
      quarto
      zig
      # --- file viewer ---
      glow
      # --- icons ---
      adwaita-icon-theme
      # --- media ---
      brightnessctl
      pamixer
      playerctl
      # --- networking ---
      networkmanagerapplet
      # --- terminal ---
      alacritty
      kitty
    ];
  };

  programs = {
    brave.enable = true;
    himalaya.enable = true;
    home-manager.enable = true;
    sioyek.enable = true;
  };
  xsession = {
    preferStatusNotifierItems = true;
  };

  services.network-manager-applet = {
    enable = true;
  };

  systemd.user = {
    sessionVariables = {
      GDK_BACKEND = "wayland";
      WAYLAND_DISPLAY = "wayland-1";
      XDG_SESSION_TYPE = "wayland";
    };

    targets = {
      tray = {
        Unit = {
          Description = "Home Manager System Tray";
          # After = [ "graphical-session.target" ];
          Requires = ["graphical-session-pre.target"];
        };
      };
    };
  };

  xdg.configFile."fish/fish_plugins".source = ../../pkgs/shell/fish/linux/fish_plugins;
}
