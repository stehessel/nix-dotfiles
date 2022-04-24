{ lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      tray = {
        enable = false;
        command = "syncthingtray --wait";
        package = pkgs.syncthingtray;
      };
    };
  };
}
