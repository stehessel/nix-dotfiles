{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      colima
    ];

    sessionVariables = {
      LIMA_HOME = "${config.xdg.configHome}/lima";
    };
  };
}
