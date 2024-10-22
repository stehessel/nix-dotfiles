{pkgs, ...}: {
  imports = [
    # ./colima
    # ./minikube
  ];

  home = {
    packages = with pkgs; [
      act
      ctop
      crane
      hadolint
      nodePackages.dockerfile-language-server-nodejs
      # podman
    ];
  };
}
