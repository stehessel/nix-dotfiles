let
  sources = import ../nix/sources.nix;
in
self: super: {
  libressl = super.libressl.overrideAttrs (
    old: {
      doCheck = false;
    }
  );
}

