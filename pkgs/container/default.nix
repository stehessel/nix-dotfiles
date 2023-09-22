{pkgs, ...}: {
  imports = [
    # ./colima
    # ./minikube
  ];

  home = {
    packages = with pkgs; [
      act
      ctop
      # Broken due to ilist Haskell package.
      hadolint
      nodePackages.dockerfile-language-server-nodejs
      # podman
    ];
  };
}
