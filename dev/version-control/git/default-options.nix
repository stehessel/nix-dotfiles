{
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
    ".vimspector.json"

    # MacOS
    ".DS_Store"

    # Direnv
    ".envrc"
    ".direnv/"
  ];

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
    core = {
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    diff = {
      submodule = "log";
    };
    pull = {
      ff = "only";
    };
    push = {
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
}
