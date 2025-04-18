{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      wget
    ];
    sessionVariables = {
      WGETRC = "${config.xdg.configHome}/wget/wgetrc";
    };
  };
  xdg.configFile."wget/wgetrc".source = config/wgetrc;
}
