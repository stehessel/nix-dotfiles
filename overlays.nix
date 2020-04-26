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
      version = "3.1";
      src = builtins.fetchGit {
        url = "https://github.com/tmux/tmux.git";
        ref = "refs/tags/3.1";
      };
    });
  })
]
