{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      k9s
      krew
      ktunnel
      kube-linter
      kubectl
      kubectx
      kubernetes-helm
      ocm
      odo
      openshift
      operator-sdk
    ];
  };
}
