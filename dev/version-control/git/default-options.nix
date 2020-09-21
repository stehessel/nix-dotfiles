{
  enable = true;

  ignores = [
    # Python
    "__pycache__/"
    "*.pyc"
    ".ropeproject"

    # Temp files
    "*~"

    # Vim
    "*.swp"
    ".vim"
    ".vimspector.json"
  ];

  extraConfig = {
    color = {
      ui = "true";
      diff-highlight = {
        oldNormal    = "red bold";
        oldHighlight = "red bold 52";
        newNormal    = "green bold";
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
