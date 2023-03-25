_: {
  xdg.configFile."dunst/dunstrc".source = config/dunstrc;
  services = {
    dunst = {
      enable = false;
      waylandDisplay = "wayland-1";
    };
  };
}
