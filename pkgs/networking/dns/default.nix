{config, pkgs, ...}: {
  home = {
    packages = with pkgs; [
      acme-sh
      lego
    ];
    sessionVariables = {
      LEGO_PATH = "${config.xdg.dataHome}/lego";
    };
  };
}
