{ lib, pkgs, ... }:
{
  programs.taskwarrior = {
    enable = true;
    config = {
      uda.priority.values = "H,M,,L";
    };
  };
}
