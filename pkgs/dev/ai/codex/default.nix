{
  config,
  inputs,
  lib,
  llms,
  pkgs,
  ...
}: let
  inherit (import ../plugins {inherit inputs;}) sources;
  codexDir = "${config.xdg.configHome}/codex";
  codexWithEnmaas =
    (pkgs.writeShellScriptBin "codex" ''
      if ! ENMAAS_KEY="$(<${lib.escapeShellArg config.sops.secrets."redhat/enmaas/token".path})" || [[ -z "$ENMAAS_KEY" ]]; then
        echo "codex: failed to load ENMAAS_KEY from sops-nix (unreadable or empty secret)." >&2
        exit 1
      fi
      export ENMAAS_KEY
      exec ${lib.getExe llms.codex} "$@"
    '').overrideAttrs (_: {
      # Home Manager uses the version to enable XDG directory support.
      inherit (llms.codex) version;
    });
in {
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    mutableSettings = true;
    plugins = with sources; [
      cc-skills-golang
      ponytail
      superpowers
    ];
    settings.marketplaces.home-manager = {
      source_type = "local";
      source = codexDir;
    };
    package =
      if config.sops.secrets ? "redhat/enmaas/token"
      then codexWithEnmaas
      else llms.codex;
  };

  # Codex resolves plugin paths relative to the directory containing .agents/.
  home.file.".agents/plugins/marketplace.json" = _: {
    config.target = "${codexDir}/.agents/plugins/marketplace.json";
    options.source = lib.mkOption {
      apply = source:
        pkgs.runCommand "codex-marketplace.json" {inherit source;} ''
          ${lib.getExe pkgs.jq} '(.plugins[].source.path) |= sub("^.*/plugins/cache/"; "./plugins/cache/")' "$source" > "$out"
        '';
    };
  };
}
