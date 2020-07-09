let
  sources = import ../nix/sources.nix;
in
self: super: {
  # alacritty = super.alacritty.overrideAttrs (old: {
  #   version = "master";
  #   src = super.fetchFromGitHub {
  #     inherit (sources.alacritty) owner repo rev sha256;
  #   };
  # });
}
