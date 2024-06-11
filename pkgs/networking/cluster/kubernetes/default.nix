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
      kubeswitch
      kustomize
      linkerd
      operator-sdk
      stern
      upbound
      velero
    ];
    sessionPath = [
      "/home/stephan/.krew/bin"
    ];
  };
}
