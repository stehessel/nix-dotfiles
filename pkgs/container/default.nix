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
      dockerfile-language-server
      hadolint
      oras
      regctl
      # podman
      skopeo
    ];
  };

  # ponytail: minimal policy to make skopeo work on macOS.
  xdg.configFile."containers/policy.json".text = builtins.toJSON {
    default = [{type = "insecureAcceptAnything";}];
  };
}
