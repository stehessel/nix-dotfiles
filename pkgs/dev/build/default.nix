{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      cmake
      gnumake
      go-task
    ];
  };
}
