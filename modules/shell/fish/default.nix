{ lib, pkgs, ... }:
{
  xdg.configFile."fish/functions" = {
    source = ./config/functions;
    recursive = true;
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      gb = "git branch";
      gc = "git commit -am";
      gp = "git push";
      gco = "git checkout";
      gw = "git switch";
      gd = "git diff";
      gs = "git status";
      gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      B = "git checkout (git for-each-ref --sort=-committerdate --count=100 --format=\"%(refname:short)\" refs/heads/ | fzf --preview \"git log {} --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --color | head -n 200\")";
      d = "cd (fd --type=d --max-depth=1 . ~/dev | fzf --preview 'ls --color=always {}')";
      tw = "task";
      t = "topgrade";
    };

    # Needed for nvim-spectre on macOS
    shellAliases = {
      gsed = "sed";
    };

    interactiveShellInit =
      ''
        set fish_greeting

        if not which gsed > /dev/null
          ln -s /etc/profiles/per-user/stephan/bin/sed $HOME/.local/bin/gsed
        end

        # Fisher
        if not functions -q fisher
            curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
            fish -c fisher
        end

        # Conda
        if test -d "$HOME/miniconda3"
            set conda_source_file "$XDG_CONFIG_HOME/fish/conda.fish"
            if not test -f $conda_source_file
                eval "$HOME/miniconda3/bin/conda" "shell.fish" hook $argv >$conda_source_file
            end
            source $conda_source_file
        end
      '';
  };
}
