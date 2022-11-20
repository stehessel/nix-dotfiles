{pkgs, ...}: {
  home.packages = with pkgs; [
    topgrade
  ];
  xdg.configFile."topgrade.toml".source = config/topgrade.toml;
}
