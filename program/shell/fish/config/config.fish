if not status is-interactive
	exit
end

# environment variables
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
set -x EDITOR "nvim"
set -x FILE "lf"
set -x PAGER "less"
set -x READER "zathura"
set -x TERMINAL "kitty"

set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
set -x FZF_ENABLE_OPEN_PREVIEW 1
set -x FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always"
set -x FZF_PREVIEW_DIR_CMD "tree"
set -x TMUX_PLUGIN_MANAGER_PATH "~/.config/tmux/plugins"

# if test -d $HOME/.npm-packages/bin
# 	set -x fish_user_paths "$HOME/.npm-packages/bin" fish_user_paths
# end
# if test -d $HOME/go/bin
# 	set -x fish_user_paths "$HOME/go/bin" fish_user_paths
# end
# if test -d $HOME/.cargo/bin
# 	set -x fish_user_paths "$HOME/.cargo/bin" fish_user_paths
# end
# if test -d $HOME/.gem/ruby/2.6.0/bin
# 	set -x fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" fish_user_paths
# end
# if test -d /nix/var/nix/profiles/default/bin
# 	set -x fish_user_paths "/nix/var/nix/profiles/default/bin" fish_user_paths
# end
# if test -d /usr/local/bin
# 	set -x fish_user_paths "/usr/local/bin" fish_user_paths
# end
# if test -d /usr/local/opt/llvm/bin
# 	set -x fish_user_paths "/usr/local/opt/llvm/bin" fish_user_paths
# end
# if test -d $HOME/.nix-profile/bin
# 	set -x fish_user_paths "$HOME/.nix-profile/bin" fish_user_paths
# end
# if test -d $HOME/.local/bin
# 	set -x fish_user_paths "$HOME/.local/bin" fish_user_paths
# end
set -p fish_user_paths "$HOME/.dotnet"
set -p fish_user_paths "$HOME/.npm-packages/bin"
set -p fish_user_paths "$HOME/go/bin"
set -p fish_user_paths "$HOME/.cargo/bin"
set -p fish_user_paths "$HOME/.gem/ruby/2.6.0/bin"
set -p fish_user_paths "/nix/var/nix/profiles/default/bin"
set -p fish_user_paths "/usr/local/bin"
set -p fish_user_paths "/usr/local/opt/llvm/bin"
set -p fish_user_paths "$HOME/.nix-profile/bin"
set -p fish_user_paths "$HOME/.local/bin"

source "$XDG_CONFIG_HOME/nix/nix-single-user.fish" 2> /dev/null
source "$XDG_CONFIG_HOME/nix/nix-daemon.fish" 2> /dev/null

# link sh to dash
ln -s (command -v dash) "$HOME/.local/bin/sh" 2> /dev/null
set -x KAKOUNE_POSIX_SHELL (command -v dash)
set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket
switch (uname)
	case Darwin
		set -p fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
		set -p fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin
		set -x LC_ALL "en_US.UTF-8"
		set -x LANG "en_US.UTF-8"
		ln -s "/Applications/Firefox.app/Contents/MacOS/firefox" "$HOME/.local/bin/firefox" 2> /dev/null
		ln -s "$XDG_CONFIG_HOME/kak-lsp/kak-lsp.toml" "$HOME/Library/Preferences/kak-lsp/kak-lsp.toml" 2> /dev/null
	case Linux
		set -x BROWSER "firefox"
end

# abbreviations
abbr -a h "cd ~/ and ls -a"
abbr -a d "cd ~/Documents; and ls -a"
abbr -a D "cd ~/Downloads; and ls -a"
abbr -a m "cd ~/Music; and ls -a"
abbr -a pp "cd ~/Pictures; and ls -a"
abbr -a vv "cd ~/Videos; and ls -a"
abbr -a cf "cd ~/.config; and ls -a"

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
abbr -a gb  "git branch"
abbr -a gc  "git commit -am"
abbr -a gco "git checkout"
abbr -a gd  "git diff"
abbr -a gs  "git status"
abbr -a tl  "tasklite"
abbr -a restic "restic -r ~/backup --password-file ~/.config/restic/secret"
abbr -a corona "curl 'https://corona-stats.online?source=2&top=15'"
abbr -a b "buku --suggest"

# keybinds
bind \cb beginning-of-line
bind \ca 'fg'

# fisher
if not functions -q fisher
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

# plug.kak
if not test -d "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
	git clone "https://github.com/andreyorst/plug.kak.git" "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
end

# direnv
if command -v direnv >/dev/null 2>&1
	eval (direnv hook fish)
end

# conda
if test -d "$HOME/miniconda3"
	set conda_config_file "$XDG_CONFIG_HOME/fish/conda.fish"
	if not test -f $conda_config_file
    	eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv > $conda_config_file
	end
	source $conda_config_file
end

# theme

# starship
# if command -v starship >/dev/null 2>&1
# 	starship init fish | source
# end

# bobthefish
set bobthefish_config_file "$XDG_CONFIG_HOME/bobthefish/config.fish"
if test -f $bobthefish_config_file
	source $bobthefish_config_file
end
