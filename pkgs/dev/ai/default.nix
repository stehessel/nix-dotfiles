{
  config,
  lib,
  llms,
  pkgs,
  ...
}: {
  imports = [
    ./claude
    ./opencode
    # ./sourcery
  ];

  home = {
    packages = builtins.concatLists [
      (with pkgs; [
        beans
        gemini-cli
        openshell
      ])
      (with llms; [
        apm
        beads
        beads-viewer
        coderabbit-cli
        kilocode-cli
        nono
      ])
    ];
  };

  programs.mcp = {
    enable = true;
    servers = {
      atlassian = {
        url = "https://mcp.atlassian.com/v1/mcp";
      };
      context7 = {
        command = "npx";
        args = ["-y" "@upstash/context7-mcp"];
      };
      gdrive = {
        command = "/Users/shesselm/go/src/gitlab.com/prodops/mcp-gdrive/.venv/bin/mcp-gdrive";
      };
      gopls = {
        command = "gopls";
        args = ["mcp"];
      };
      home-assistant = {
        url = config.sops.placeholder."home-assistant/ha-mcp/webhook";
      };
      nixos = {
        command = "uvx";
        args = ["mcp-nixos"];
      };
      rover-search = {
        command = "npx";
        args = ["-y" "git+ssh://git@gitlab.cee.redhat.com/prodops/mcp/mcp-rover-search.git"];
        type = "stdio";
      };
    };
  };

  sops.templates."mcp.json".file = (pkgs.formats.json {}).generate "mcp.json" {
    mcpServers = lib.mapAttrs (
      _: server:
      lib.hm.mcp.transformMcpServer {
        inherit server;
        extraTransforms = [lib.hm.mcp.addType];
        exclude = ["serverUrl"];
      }
    ) config.programs.mcp.servers;
  };
  xdg.configFile."mcp/mcp.json".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink config.sops.templates."mcp.json".path);
}
