self: super: {
  clojure-lsp = super.clojure-lsp.overrideAttrs (
    old: {
      doCheck = false;
    }
  );
}
