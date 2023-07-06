{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      buildpack
      cmake
      gnumake
      go-task
    ];
  };
}
