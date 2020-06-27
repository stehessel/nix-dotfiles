let
  sources = import ../nix/sources.nix;
in
self: super: {
  dash = super.dash.overrideAttrs (old: rec {
    name = "dash-0.5.10.2";
    src = builtins.fetchurl {
      url = "http://gondor.apana.org.au/~herbert/dash/files/${name}.tar.gz";
      sha256 = "0wb0bwmqc661hylqcfdp7l7x12myw3vpqk513ncyqrjwvhckjriw";
    };
  });
}
