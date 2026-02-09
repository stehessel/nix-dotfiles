{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      actionlint
      buildpack
      checkmake
      cmake
      gnumake
      # go-task
    ];
    sessionVariables = {
      PACK_HOME = "${config.xdg.configHome}/pack";
    };
  };
}
