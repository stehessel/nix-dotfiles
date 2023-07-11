{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      buildpack
      cmake
      gnumake
      go-task
    ];
    sessionVariables = {
      PACK_HOME = "${config.xdg.configHome}/pack";
    };
  };
}
