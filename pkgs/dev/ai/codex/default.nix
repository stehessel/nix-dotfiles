{
  config,
  lib,
  pkgs,
  ...
}: let
  codex =
    (pkgs.writeShellScriptBin "codex" ''
      if ! ENMAAS_KEY="$(<${lib.escapeShellArg config.sops.secrets."redhat/enmaas/token".path})" || [[ -z "$ENMAAS_KEY" ]]; then
        echo "codex: failed to load ENMAAS_KEY from sops-nix (unreadable or empty secret)." >&2
        exit 1
      fi
      export ENMAAS_KEY
      exec ${lib.getExe pkgs.codex} "$@"
    '').overrideAttrs (_: {
      # Home Manager uses the version to enable XDG directory support.
      inherit (pkgs.codex) version;
    });
in {
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    mutableSettings = true;
    package = codex;
  };
}
