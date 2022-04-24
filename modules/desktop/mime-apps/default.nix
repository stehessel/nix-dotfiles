{ lib, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.xdg.mimeAssociations [
      pkgs.brave
      pkgs.sioyek
    ];
  };
}
