{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      hcloud
    ];
  };
}
