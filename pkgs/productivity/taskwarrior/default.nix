{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      tasksh
    ];
  };
  programs.taskwarrior = {
    enable = false;
    config = {
      uda.priority.values = "H,M,,L";
    };
    package = pkgs.taskwarrior3;
  };
}
