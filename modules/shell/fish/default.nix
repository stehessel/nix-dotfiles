{ pkgs, lib, ... }:
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

    interactiveShellInit =
      ''
        # Environment variables
        set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height 85% --preview-window=wrap --info=inline"
        set -x fzf_fd_opts "--type=file"
        # set -x fzf_dir_opts --bind="enter:execute(nvim {})"
        set -x fzf_preview_dir_cmd "exa --all --color=always --group-directories-first"
        # fzf_configure_bindings --directory=\cf

        set -e fish_user_paths

        # Link sh to dash
        ln -s (command -v dash) "$HOME/.local/bin/sh" 2>/dev/null
        set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket
        switch (uname)
            case Darwin
                fish_add_path /usr/local/opt/coreutils/libexec/gnubin
                fish_add_path /usr/local/opt/gnu-sed/libexec/gnubin
                fish_add_path /usr/local/opt/openjdk/bin
                set -x LC_ALL "en_US.UTF-8"
                set -x LANG "en_US.UTF-8"
            case Linux
                set -x BROWSER firefox
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

        # Bobthefish
        set bobthefish_config_file "$XDG_CONFIG_HOME/bobthefish/config.fish"
        if test -f $bobthefish_config_file
            source $bobthefish_config_file
        end
      '';
  };
}
