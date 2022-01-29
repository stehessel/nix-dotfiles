{ pkgs, lib, ... }:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        git_status = {
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
        };
      };
    };
  };
}
