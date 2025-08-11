{pkgs, ...}: {
  imports = [
    # ./colima
    # ./minikube
  ];

  home = {
    packages = with pkgs; [
      act
      crane
      ctop
      dockerfile-language-server-nodejs
      hadolint
      # podman
    ];
  };
}
