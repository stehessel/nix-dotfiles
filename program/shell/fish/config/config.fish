# environment variables
set -x BROWSER "firefox"
set -x EDITOR "kak"
set -x FILE "vifm"
set -x READER "zathura"
set -x TERMINAL "kitty"
set -x FZF_LEGACY_KEYBINDINGS "0"

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

abbr -a -U bf "$EDITOR ~/.config/bmfiles"
abbr -a -U bd "$EDITOR ~/.config/bmdirs"
abbr -a -U cfb "$EDITOR ~/nix-home/desktop/window-manager/bspwm/config/bspwmrc"
abbr -a -U cfx "$EDITOR ~/nix-home/desktop/window-manager/xmonad/config/xmonad.hs"
abbr -a -U cfq "$EDITOR ~/nix-home/desktop/window-manager/qtile/config/config.py"
abbr -a -U cfp "$EDITOR ~/nix-home/desktop/compositor/picom/config/picom.conf"
abbr -a -U cfs "$EDITOR ~/nix-home/desktop/sxhkd/config/sxhkdrc"
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

# theme
starship init fish | source

# Nix
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  bax "source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'"
end
bax "source ~/.nixpath"
bax "source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# End Nix
