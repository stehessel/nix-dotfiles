{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      cilium-cli
      fluxcd
      glooctl
      hubble
      istioctl
      k9s
      kind
      kops
      krew
      ktunnel
      kube-linter
      kubeconform
      kubectl
      kubectx
      kustomize
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.kubernetes-helmPlugins.helm-secrets
        ];
      })
      linkerd
      operator-sdk
    ];
    sessionPath = [
      "/home/stephan/.krew/bin"
    ];
  };
}
