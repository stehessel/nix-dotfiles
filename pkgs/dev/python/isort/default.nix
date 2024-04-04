{pkgs, ...}: {
  xdg.configFile.".isort.cfg".source = config/isort.cfg;
  home = {
    packages = with pkgs; [
      python310Packages.isort
    ];
  };
}
