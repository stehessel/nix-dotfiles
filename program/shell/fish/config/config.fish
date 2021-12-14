if not status is-interactive
    exit
end

# Environment variables
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
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

set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
set -x TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
set -x CARGO_HOME "$XDG_CONFIG_HOME/cargo"

fish_add_path "$HOME/.luarocks/bin"
fish_add_path "$HOME/.npm-packages/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.config/cargo/bin"
fish_add_path "$HOME/.gem/ruby/2.6.0/bin"
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
        set -x LC_ALL "en_US.UTF-8"
        set -x LANG "en_US.UTF-8"
        ln -s "/Applications/Firefox.app/Contents/MacOS/firefox" "$HOME/.local/bin/firefox" 2>/dev/null
    case Linux
        set -x BROWSER firefox
end

# Abbreviations
abbr -a cfb "$EDITOR ~/nix-home/program/desktop/window-manager/bspwm/config/bspwmrc"
abbr -a cfq "$EDITOR ~/nix-home/program/desktop/window-manager/qtile/config/config.py"
abbr -a cfp "$EDITOR ~/nix-home/program/desktop/compositor/picom/config/picom.conf"
abbr -a cfs "$EDITOR ~/nix-home/program/desktop/sxhkd/config/sxhkdrc"
abbr -a cfv "$EDITOR ~/nix-home/program/editor/neovim/config/init.vim"

if test "$TERMINAL" = kitty
    abbr -a diff "kitty +kitten diff"
end
abbr -a gb "git branch"
abbr -a gc "git commit -am"
abbr -a gp "git push"
abbr -a gco "git checkout"
abbr -a gw "git switch"
abbr -a gd "git diff"
abbr -a gs "git status"
abbr -a gl "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr -a B "git checkout (git for-each-ref --sort=-committerdate --count=100 --format=\"%(refname:short)\" refs/heads/ | fzf --preview \"git log {} --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --color | head -n 200\")"
abbr -a d "cd (fd --type=d --max-depth=1 . ~/git | fzf --preview 'ls --color=always {}')"
abbr -a tw task
abbr -a restic "restic --repo=~/OneDrive\ -\ Blue\ Yonder --password-file=$XDG_CONFIG_HOME/restic/secret"
abbr -a e "$EDITOR"
abbr -a b "buku --suggest"
abbr -a t topgrade

# Keybinds
bind \cb beginning-of-line
bind \ca fg
bind \cn "f --pick"

# Fisher
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Tmux
# if test -n "$TMUX"
#     eval (tmux show-environment -s $NVIM_LISTEN_ADDRESS)
# end

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
