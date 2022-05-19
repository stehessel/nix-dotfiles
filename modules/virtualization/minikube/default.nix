{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      minikube
    ];

    sessionVariables = {
      MINIKUBE_HOME = "${config.xdg.configHome}";
    };
  };
}
