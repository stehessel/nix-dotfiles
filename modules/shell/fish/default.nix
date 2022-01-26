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
        set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME "$HOME/.cache"
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
        set -q XDG_DATA_HOME; or set XDG_DATA_HOME "$HOME/.local/share"
        set -q XDG_RUNTIME_DIR; or set XDG_RUNTIME_DIR "$TMPDIR"
        set -x EDITOR nvim
        set -x FILE lf
        set -x PAGER less
        set -x READER zathura
        set -x TERMINAL kitty

        set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height 85% --preview-window=wrap --info=inline"
        set -x fzf_fd_opts "--type=file"
        # set -x fzf_dir_opts --bind="enter:execute(nvim {})"
        set -x fzf_preview_dir_cmd "exa --all --color=always --group-directories-first"
        # fzf_configure_bindings --directory=\cf

        set -x BOTO_CONFIG "$XDG_CONFIG_HOME/boto/config"
        set -x CARGO_HOME "$XDG_CONFIG_HOME/cargo"
        set -x GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
        set -x LEIN_HOME "$XDG_CONFIG_HOME/lein"
        set -x MINIKUBE_HOME "$XDG_CONFIG_HOME"
        set -x NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
        set -x NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
        set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
        set -x PYTHONSTARTUP "XDG_CONFIG_HOME/python/config"
        set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
        set -x RUSTUP_HOME "$XDG_CONFIG_HOME/rustup"
        set -x TASKDATA "$XDG_CONFIG_HOME/taskwarrior/task"
        set -x TASKRC "$XDG_CONFIG_HOME/taskwarrior/config"
        set -x TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
        set -x WGETRC "$XDG_CONFIG_HOME/wget/config"

        set -e fish_user_paths
        fish_add_path "$HOME/.luarocks/bin"
        fish_add_path "$XDG_CONFIG_HOME/npm/npm-packages/bin"
        fish_add_path "$HOME/go/bin"
        fish_add_path "$HOME/.config/cargo/bin"
        fish_add_path /nix/var/nix/profiles/default/bin
        fish_add_path /usr/local/bin
        fish_add_path "$HOME/.nix-profile/bin"
        fish_add_path "$HOME/.local/bin"
        fish_add_path "$HOME/miniconda3/bin"

        # Link sh to dash
        ln -s (command -v dash) "$HOME/.local/bin/sh" 2>/dev/null
        set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket
        switch (uname)
            case Darwin
                fish_add_path /usr/local/opt/coreutils/libexec/gnubin
                fish_add_path /usr/local/opt/gnu-sed/libexec/gnubin
                fish_add_path /usr/local/opt/openjdk/bin
                fish_add_path /Users/stephan/go/src/github.com/stackrox/workflow/bin
                set -x LC_ALL "en_US.UTF-8"
                set -x LANG "en_US.UTF-8"
                ln -s "/Applications/Firefox.app/Contents/MacOS/firefox" "$HOME/.local/bin/firefox" 2>/dev/null
            case Linux
                set -x BROWSER firefox
        end

        # Fisher
        if not functions -q fisher
            curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
            fish -c fisher
        end

        # Direnv
        if command -v direnv >/dev/null 2>&1
            eval (direnv hook fish)
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
