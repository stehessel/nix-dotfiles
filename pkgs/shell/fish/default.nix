_: {
  xdg.configFile."fish/functions" = {
    source = ./config/functions;
    recursive = true;
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      B = ''
        git checkout (git for-each-ref --sort=-committerdate --count=100 --format='%(refname:short)' refs/heads/ | fzf --preview 'git log {} --pretty=format:''\\''\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''\\''\" --abbrev-commit --date=relative --color | head -n 200')
      '';
      d = "cd (fd --type=d --max-depth=1 . ~/dev | fzf --preview 'ls --color=always {}')";
      f = "flux get kustomizations";
      gP = "git pull";
      ga = "git add";
      gb = "git branch";
      gc = "git commit -am";
      gco = "git checkout";
      gd = "git diff";
      gf = "git fetch upstream; git pull upstream master";
      gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      gp = "git push";
      gs = "git status";
      gw = "git switch";
      gr = "git restore";
      i = "istioctl";
      k = "kubectl";
      K = "kind";
      n = "nixos-rebuild switch --flake . --use-remote-sudo";
      t = "task";
      tf = "terraform";
    };

    interactiveShellInit = ''
      set fish_greeting

      # Open files with Ctrl-f
      fzf_configure_bindings --directory=\cf --git_log=\cg
      set fzf_directory_opts --bind "enter:abort+execute($EDITOR {} &> /dev/tty)"

      # Fisher
      if not functions -q fisher
          curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
          fish -c fisher
      end
    '';
  };
}
