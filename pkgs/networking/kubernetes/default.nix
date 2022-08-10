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
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          # pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.kubernetes-helmPlugins.helm-secrets
        ];
      })
      ocm
      odo
      openshift
      operator-sdk
    ];
  };
}
