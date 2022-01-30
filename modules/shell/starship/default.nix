{ lib, pkgs, ... }:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        gcloud.disabled = true;
        git_status = {
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
        };
      };
    };
  };
}
