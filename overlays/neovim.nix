let
  sources = import ../nix/sources.nix;
in
self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
    version = "master";
    src = super.fetchFromGitHub {
      inherit (sources.neovim) owner repo rev sha256;
    };
    buildInputs = old.buildInputs ++ [ super.utf8proc ];
  });
}
