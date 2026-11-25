{
  config,
  lib,
  pkgs,
  ...
}: let
  webhookSecret = "home-assistant/ha-mcp/webhook";
  ha-mcp = pkgs.writeShellScript "ha-mcp" ''
    : "''${HA_MCP_WEBHOOK:?Home Assistant MCP webhook key is missing}"
    export SSE_URL="https://home.stephan.sh/api/webhook/$HA_MCP_WEBHOOK"
    # The proxy includes the credential-bearing URL in its HTTP diagnostics.
    ${lib.getExe pkgs.mcp-proxy} --transport streamablehttp 2>/dev/null || {
      echo "Home Assistant MCP proxy failed. Check the webhook key and endpoint." >&2
      exit 1
    }
  '';
in {
  programs.mcp.servers.home-assistant = lib.mkIf (builtins.hasAttr webhookSecret config.sops.secrets) {
    command = toString ha-mcp;
    env.HA_MCP_WEBHOOK.file = config.sops.secrets.${webhookSecret}.path;
  };
}
