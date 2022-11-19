{
  lib,
  pkgs,
  ...
}: {
  home = {
    # `home-manager` currently has issues adding them to `~/Applications`
    # Issue: https://github.com/nix-community/home-manager/issues/1341
    # packages = with pkgs; [
    #   kitty
    # ];
    sessionVariables = {
      TERMINAL = "kitty";
    };
  };
  xdg.configFile."kitty" = {
    source = ./config;
    recursive = true;
  };
}
