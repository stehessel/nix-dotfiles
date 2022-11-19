{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = config.lib.xdg.mimeAssociations [
      pkgs.brave
      # pkgs.sioyek
    ];
  };
}
