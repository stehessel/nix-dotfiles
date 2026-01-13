{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      sourcery
    ];
  };
}
