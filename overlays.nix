[
  (self: super:
  {
    neovim = super.neovim-unwrapped.overrideAttrs (old: rec {
      version = "nightly";
      src = builtins.fetchGit {
        url = "https://github.com/neovim/neovim.git";
        ref = "refs/tags/nightly";
      };
    });
  })
  (self: super:
  {
    tmux = super.tmux.overrideAttrs (old: rec {
      version = "HEAD";
      src = builtins.fetchGit {
        url = "https://github.com/tmux/tmux.git";
        ref = "refs/heads/master";
      };
    });
  })
]
