{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./helm
  ];

  home = {
    packages = with pkgs; [
      cilium-cli
      fluxcd
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
    sessionVariables = {
      KREW_ROOT = "${config.xdg.dataHome}/krew";
    };
    sessionPath = [
      "${config.xdg.dataHome}/krew"
    ];
  };
}
