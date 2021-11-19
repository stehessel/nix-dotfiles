let
  sources = import ../nix/sources.nix;
in
self: super: {
  clojure-lsp = super.clojure-lsp.overrideAttrs (
    old: {
      doCheck = false;
    }
  );
}
