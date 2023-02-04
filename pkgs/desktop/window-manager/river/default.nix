{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      river
    ];
  };
  xdg.configFile."river/init".source = config/init;
}
