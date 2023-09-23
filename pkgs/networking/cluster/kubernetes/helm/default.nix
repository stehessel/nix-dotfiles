{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      helm-ls
      kustomize
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.kubernetes-helmPlugins.helm-secrets
        ];
      })
    ];
  };
}
