# environment variables
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
set -x BROWSER "firefox"
set -x EDITOR "nvim"
set -x FILE "lf"
set -x PAGER "less"
set -x READER "zathura"
set -x TERMINAL "kitty"
set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/rc"
set -p fish_user_paths "$HOME/.npm-packages/bin"
set -p fish_user_paths "$HOME/.cargo/bin"
set -p fish_user_paths "$HOME/.gem/ruby/2.6.0/bin"
set -p fish_user_paths "/nix/var/nix/profiles/default/bin"
set -p fish_user_paths "/usr/local/bin"
set -p fish_user_paths "/usr/local/opt/llvm/bin"
set -p fish_user_paths "$HOME/.nix-profile/bin"
set -p fish_user_paths "$HOME/.local/bin"
# link sh to dash
ln -s (which dash) "$HOME/.local/bin/sh" 2> /dev/null
set -x KAKOUNE_POSIX_SHELL (which dash)
set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket
switch (uname)
	case Darwin
		source "$XDG_CONFIG_HOME/nix/nix-single-user.fish"
		set -p fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
		set -p fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin
		set -x LC_ALL "en_US.UTF-8"
		set -x LANG "en_US.UTF-8"
		# ssh-add -K $HOME/.ssh/lgtf_rsa &>/dev/null
		# ssh-add -K $HOME/.ssh/yulc_rsa &>/dev/null
		ln -s "$XDG_CONFIG_HOME/kak-lsp/kak-lsp.toml" 2> /dev/null "$HOME/Library/Preferences/kak-lsp/kak-lsp.toml"
	case Linux
		source "$XDG_CONFIG_HOME/nix/nix-daemon.fish"
end

# abbreviations
abbr -a -U h "cd ~/ and ls -a"
abbr -a -U b "cd ~/backgrounds and ls -a"
abbr -a -U d "cd ~/Documents; and ls -a"
abbr -a -U D "cd ~/Downloads; and ls -a"
abbr -a -U m "cd ~/Music; and ls -a"
abbr -a -U pp "cd ~/Pictures; and ls -a"
abbr -a -U vv "cd ~/Videos; and ls -a"
abbr -a -U cf "cd ~/.config; and ls -a"

abbr -a -U cfb "$EDITOR ~/nix-home/program/desktop/window-manager/bspwm/config/bspwmrc"
abbr -a -U cfx "$EDITOR ~/nix-home/program/desktop/window-manager/xmonad/config/xmonad.hs"
abbr -a -U cfq "$EDITOR ~/nix-home/program/desktop/window-manager/qtile/config/config.py"
abbr -a -U cfp "$EDITOR ~/nix-home/program/desktop/compositor/picom/config/picom.conf"
abbr -a -U cfs "$EDITOR ~/nix-home/program/desktop/sxhkd/config/sxhkdrc"
abbr -a -U cfk "$EDITOR ~/nix-home/program/editor/kakoune/config/kakrc"
abbr -a -U cfv "$EDITOR ~/nix-home/program/editor/neovim/config/init.vim"
abbr -a -U cfm "$EDITOR ~/.config/neomutt/neomuttrc"
abbr -a -U cfu "$EDITOR ~/.config/newsboat/urls"
abbr -a -U cfn "$EDITOR ~/.config/newsboat/config"
abbr -a -U cfmb "$EDITOR ~/.config/ncmpcpp/bindings"
abbr -a -U cfmc "$EDITOR ~/.config/ncmpcpp/config"

if test "$TERMINAL" = "kitty"
	abbr -a -U diff "kitty +kitten diff"
end
abbr -a -U gc "git commit -am"
abbr -a -U gd "git diff"
abbr -a -U gs "git status"
abbr -a -U tl "tasklite"
abbr -a -U corona "curl 'https://corona-stats.online?source=2&top=15'"

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
eval (direnv hook fish)

# conda
if test -d "$HOME/miniconda3"
	source $XDG_CONFIG_HOME/fish/conda.fish
    # eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
end

# theme

# starship
# starship init fish | source

# bobthefish
source $XDG_CONFIG_HOME/bobthefish/config.fish
