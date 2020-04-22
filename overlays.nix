[
  (self: super:
  {
    neovim = super.neovim.overrideAttrs (old: rec {
      src = builtins.fetchGit {
        url = "https://github.com/neovim/neovim.git";
        ref = "refs/tags/nightly";
      };
    });
  })
  # (self: super:
  # {
  #   fish = super.fish.overrideAttrs (old: rec {
  #     pname = "fish";
  #     version = "3.0.0";
  #     src = super.fetchurl {
  #       url = "https://github.com/fish-shell/fish-shell/releases/download/3.0.0/fish-3.0.0.tar.gz";
  #       sha256 = "1kzjd0n0sfslkd36lzrvvvgy3qwkd9y466bkrqlnhd5h9dhx77ga";
  #     };
  #   });
  # })
]
