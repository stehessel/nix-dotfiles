{pkgs, ...}: {
  imports = [
    ./helm
  ];

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
      linkerd
      operator-sdk
      upbound
      velero
    ];
    sessionPath = [
      "/home/stephan/.krew/bin"
    ];
  };
}
