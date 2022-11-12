{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      fluxcd
      glooctl
      istioctl
      k9s
      kind
      krew
      ktunnel
      kube-linter
      kubectl
      kubectx
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.kubernetes-helmPlugins.helm-secrets
        ];
      })
      ocm
      odo
      openshift
      operator-sdk
    ];
    sessionPath = [
      "/home/stephan/.krew/bin"
    ];
  };
}
