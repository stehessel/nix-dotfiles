{
  lib,
  pkgs,
  ...
}: {
  services = {
    swhkd = {
      enable = true;
      keybindings = {
        "super + shift + c" = "${pkgs.foot}/bin/foot";
      };
      systemd = {
        enable = true;
      };
    };
  };
}
