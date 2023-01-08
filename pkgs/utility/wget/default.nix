{config, ...}: {
  home.sessionVariables = {
    WGETRC = "${config.xdg.configHome}/wget/wgetrc";
  };
  xdg.configFile."wget/wgetrc".source = config/wgetrc;
}
