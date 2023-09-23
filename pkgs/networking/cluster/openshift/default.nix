{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ocm
      odo
      openshift
      rhoas
    ];
  };
}
