{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      git-town
      gitAndTools.git-bug
      gitAndTools.git-fame
      nodePackages."@withgraphite/graphite-cli"
      pre-commit
    ];
  };

  programs = {
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    gitui = {
      enable = true;
    };

    git = {
      enable = true;

      ignores = [
        # Python
        ".mutmut-cache"
        "__pycache__/"
        "*.pyc"
        ".ropeproject"

        # Custom root marker
        ".root"

        # Temp files
        "*~"

        # Vim
        "*.swp"
        ".vim"

        # MacOS
        ".DS_Store"

        # Direnv
        ".envrc"
        ".direnv/"
      ];

      delta = {
        enable = true;
        options = {
          line-numbers = true;
        };
      };

      extraConfig = {
        alias = {
          # Usage: git assume fileName
          assume = "update-index --assume-unchanged";
          # Usage: git noassume fileName
          noassume = "update-index --no-assume-unchanged";
          # Another alias because I cannot remember un/no either
          unassume = "!git noassume";
          # List all currently git assumed files
          assumed = "!git ls-files -v | grep ^h | cut -c 3-";
        };
        color = {
          ui = "true";
          diff-highlight = {
            oldNormal = "red bold";
            oldHighlight = "red bold 52";
            newNormal = "green bold";
            newHighlight = "green bold 22";
          };
          diff = {
            meta = "11";
            frag = "magenta bold";
            commit = "yellow bold";
            old = "red bold";
            new = "green bold";
            whitespace = "red reverse";
          };
        };
        diff = {
          submodule = "log";
        };
        pull = {
          ff = "only";
        };
        push = {
          autoSetupRemote = true;
          recurseSubmodules = "check";
        };
        status = {
          submoduesummary = 1;
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
      };
    };
  };
}
