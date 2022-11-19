{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."dunst/dunstrc".source = config/dunstrc;
  services = {
    dunst = {
      enable = true;
      waylandDisplay = "wayland-1";
    };
  };
}
