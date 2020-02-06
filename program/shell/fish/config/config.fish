# environment variables
set -x BROWSER "firefox"
set -x EDITOR "kak"
set -x FILE "vifm"
set -x READER "zathura"
set -x TERMINAL "kitty"
set -x FZF_LEGACY_KEYBINDINGS "0"
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
switch (uname)
	case Darwin
		set -p fish_user_paths "$HOME/Library/Python/3.7/bin"
		set -x LC_ALL "en_US.UTF-8"  
		set -x LANG "en_US.UTF-8"
end

# abbreviations
abbr -a -U h "cd ~/ and ls -a"
abbr -a -U b "cd ~/backgrounds and ls -a"
abbr -a -U d "cd ~/Documents and ls -a"
abbr -a -U D "cd ~/Downloads and ls -a"
abbr -a -U m "cd ~/Music and ls -a"
abbr -a -U pp "cd ~/Pictures and ls -a"
abbr -a -U vv "cd ~/Videos and ls -a"
abbr -a -U cf "cd ~/.config and ls -a"
abbr -a -U sc "cd ~/.local/bin and ls -a"
abbr -a -U mn "cd /mnt and ls -a"

abbr -a -U cfb "$EDITOR ~/nix-home/program/desktop/window-manager/bspwm/config/bspwmrc"
abbr -a -U cfx "$EDITOR ~/nix-home/program/desktop/window-manager/xmonad/config/xmonad.hs"
abbr -a -U cfq "$EDITOR ~/nix-home/program/desktop/window-manager/qtile/config/config.py"
abbr -a -U cfp "$EDITOR ~/nix-home/program/desktop/compositor/picom/config/picom.conf"
abbr -a -U cfs "$EDITOR ~/nix-home/program/desktop/sxhkd/config/sxhkdrc"
abbr -a -U cfk "$EDITOR ~/nix-home/program/editor/kakoune/config/kakrc"
abbr -a -U cfm "$EDITOR ~/.config/neomutt/neomuttrc"
abbr -a -U cfu "$EDITOR ~/.config/newsboat/urls"
abbr -a -U cfn "$EDITOR ~/.config/newsboat/config"
abbr -a -U cfmb "$EDITOR ~/.config/ncmpcpp/bindings"
abbr -a -U cfmc "$EDITOR ~/.config/ncmpcpp/config"

# aliases
alias cat "bat"
alias ls "exa"
alias tree "exa -T"
alias dotfiles "/usr/bin/git --git-dir=/home/stephan/.dotfiles --work-tree=/home/stephan"
alias vpn_off "sudo systemctl stop wg-quick@wg0"
alias vpn_tunnel "sudo systemctl start wg-quick@wg0"

# keybinds
bind \cb beginning-of-line
bind \ca 'fg'

# plug.kak
if not test -d "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
	git clone "https://github.com/andreyorst/plug.kak.git" "$XDG_CONFIG_HOME/kak/plugins/plug.kak"
end

# fisher
if not functions -q fisher
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

# nix
source "$XDG_CONFIG_HOME/nix/nix-daemon.fish"
set -x -p NIX_PATH "$HOME/.nix-defexpr/channels"

# theme
starship init fish | source

# conda
eval /Users/lgtf/miniconda3/bin/conda "shell.fish" "hook" $argv | source
