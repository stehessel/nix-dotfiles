[
  # TODO: Remove once dash-0.5.11 no longer breaks on macOS
  (self: super:
  {
    dash = super.dash.overrideAttrs (old: rec {
      name = "dash-0.5.10.2";
      src = builtins.fetchurl {
        url = "http://gondor.apana.org.au/~herbert/dash/files/${name}.tar.gz";
        sha256 = "0wb0bwmqc661hylqcfdp7l7x12myw3vpqk513ncyqrjwvhckjriw";
      };
    });
  })

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
