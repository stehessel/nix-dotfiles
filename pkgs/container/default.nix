{pkgs, ...}: {
  imports = [
    # ./colima
    # ./minikube
  ];

  home = {
    packages = with pkgs; [
      act
      ctop
      hadolint
      nodePackages.dockerfile-language-server-nodejs
      # podman
    ];
  };
}
