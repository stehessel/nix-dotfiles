{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      tasksh
    ];
  };
  programs.taskwarrior = {
    enable = true;
    config = {
      uda.priority.values = "H,M,,L";
    };
    package = pkgs.taskwarrior3;
  };
}
