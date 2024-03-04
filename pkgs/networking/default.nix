{pkgs, ...}: {
  imports = [
    ./cluster/kubernetes
    ./cluster/openshift
    ./dns
  ];

  home = {
    packages = with pkgs; [
      httpstat
    ];
  };
}
