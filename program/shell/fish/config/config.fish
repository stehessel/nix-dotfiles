# if not status is-interactive
# 	exit
# end

# Environment variables
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
set -x EDITOR "nvim"
set -x FILE "lf"
set -x PAGER "less"
set -x READER "zathura"
set -x TERMINAL "kitty"

set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height 85% --preview-window=wrap --info=inline'
set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
set -x NVIM_LOG_FILE "$XDG_CONFIG_HOME/nvim/.nvimlog"
set -x TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
set -x ODBCSYSINI "$HOME/git/raq"
set -x CARGO_HOME "$XDG_CONFIG_HOME/cargo"

set -p fish_user_paths "$HOME/.dotnet"
set -p fish_user_paths "$HOME/.luarocks/bin"
set -p fish_user_paths "$HOME/.npm-packages/bin"
set -p fish_user_paths "$HOME/go/bin"
set -p fish_user_paths "$HOME/.cargo/bin"
set -p fish_user_paths "$HOME/.gem/ruby/2.6.0/bin"
set -p fish_user_paths "/nix/var/nix/profiles/default/bin"
set -p fish_user_paths "/usr/local/bin"
# set -p fish_user_paths "/usr/local/opt/llvm/bin"
set -p fish_user_paths "$HOME/.nix-profile/bin"
set -p fish_user_paths "$HOME/.local/bin"
set -p fish_user_paths "$HOME/miniconda3/bin"

source "$XDG_CONFIG_HOME/nix/nix-single-user.fish" 2> /dev/null
source "$XDG_CONFIG_HOME/nix/nix-daemon.fish" 2> /dev/null

# Link sh to dash
ln -s (command -v dash) "$HOME/.local/bin/sh" 2> /dev/null
set -x KAKOUNE_POSIX_SHELL (command -v dash)
set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket
switch (uname)
	case Darwin
		set -x BY_ROOT_CERT $HOME/certs/rootca-2016-07.crt
		set -p fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
		set -p fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin
		set -x LC_ALL "en_US.UTF-8"
		set -x LANG "en_US.UTF-8"
		ln -s "/Applications/Firefox.app/Contents/MacOS/firefox" "$HOME/.local/bin/firefox" 2> /dev/null
		ln -s "$XDG_CONFIG_HOME/kak-lsp/kak-lsp.toml" "$HOME/Library/Preferences/kak-lsp/kak-lsp.toml" 2> /dev/null
	case Linux
		set -x BROWSER "firefox"
end

# Abbreviations
abbr -a h "cd ~/ and ls -a"
abbr -a d "cd ~/Documents; and ls -a"
abbr -a D "cd ~/Downloads; and ls -a"
abbr -a m "cd ~/Music; and ls -a"
abbr -a pp "cd ~/Pictures; and ls -a"
abbr -a vv "cd ~/Videos; and ls -a"
abbr -a cf "cd $XDG_CONFIG_HOME; and ls -a"

abbr -a cfb "$EDITOR ~/nix-home/program/desktop/window-manager/bspwm/config/bspwmrc"
abbr -a cfx "$EDITOR ~/nix-home/program/desktop/window-manager/xmonad/config/xmonad.hs"
abbr -a cfq "$EDITOR ~/nix-home/program/desktop/window-manager/qtile/config/config.py"
abbr -a cfp "$EDITOR ~/nix-home/program/desktop/compositor/picom/config/picom.conf"
abbr -a cfs "$EDITOR ~/nix-home/program/desktop/sxhkd/config/sxhkdrc"
abbr -a cfk "$EDITOR ~/nix-home/program/editor/kakoune/config/kakrc"
abbr -a cfv "$EDITOR ~/nix-home/program/editor/neovim/config/init.vim"

if test "$TERMINAL" = "kitty"
	abbr -a diff "kitty +kitten diff"
end
abbr -a lg  "lazygit"
abbr -a gb  "git branch"
abbr -a gc  "git commit -am"
abbr -a gco "git checkout"
abbr -a gw  "git switch"
abbr -a gd  "git diff"
abbr -a gs  "git status"
abbr -a gl  "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr -a B "git checkout (git for-each-ref --sort=-committerdate --count=100 --format=\"%(refname:short)\" refs/heads/ | fzf --preview \"git log {} --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --color | head -n 200\")"
abbr -a d "cd (fd --type=d --max-depth=1 . ~/git | fzf --preview 'ls --color=always {}')"
abbr -a tl  "tasklite"
abbr -a restic "restic -r ~/backup --password-file $XDG_CONFIG_HOME/restic/secret"
abbr -a corona "curl 'https://corona-stats.online?source=2&top=15'"
abbr -a e "$EDITOR"
abbr -a b "buku --suggest"
abbr -a a "fuzzycred"
abbr -a s "fuzzysphere"
abbr -a p "pytest --ignore tests/unit/compat_pricing/test_build_data_db.py --ignore tests/unit/test_log_stats.py --ignore tests/unit/test_build_datasets.py::test_get_source_data_logging -n auto tests/unit"
abbr -a t "topgrade"
abbr -a c "clear"

# Keybinds
bind \cb beginning-of-line
bind \ca fg
bind \cn "f --pick"

# Fisher
if not functions -q fisher
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

# Plug.kak
# if not test -d "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
# 	git clone "https://github.com/andreyorst/plug.kak.git" "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
# end

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
    	eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv > $conda_source_file
	end
	source $conda_source_file
end

# Pyenv
if command -v pyenv > /dev/null
	set -x PYENV_ROOT $XDG_CONFIG_HOME/pyenv
	set pyenv_source_file "$XDG_CONFIG_HOME/fish/pyenv.fish"
	if not test -f $pyenv_source_file
		pyenv init - > $pyenv_source_file
	end
	# source $pyenv_source_file
end

# Theme
# Starship
# if command -v starship >/dev/null 2>&1
# 	starship init fish | source
# end

# Bobthefish
set bobthefish_config_file "$XDG_CONFIG_HOME/bobthefish/config.fish"
if test -f $bobthefish_config_file
	source $bobthefish_config_file
end
