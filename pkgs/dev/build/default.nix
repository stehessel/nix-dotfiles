{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      actionlint
      buildpack
      cmake
      gnumake
      # go-task
    ];
    sessionVariables = {
      PACK_HOME = "${config.xdg.configHome}/pack";
    };
  };
}
