{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ocm
      openshift
      # rhoas
    ];
  };
}
