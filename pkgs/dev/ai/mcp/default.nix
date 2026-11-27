{
  config,
  inputs,
  pkgs,
  pkgs-stable,
  lib,
  ...
}: let
  npxServer = args: {
    command = "npx";
    inherit args;
    env = {inherit (config.home.sessionVariables) NPM_CONFIG_CACHE;};
  };
  # Prowject imports FastMCP from the v1 Python SDK.
  prowjectPython = pkgs-stable.python3.withPackages (ps: [ps.httpx ps.mcp ps.python-dateutil]);
  kubernetesConfig = pkgs.writeText "kubernetes-mcp-server.toml" ''
    read_only = true
  '';
in {
  imports = [./ha-mcp];

  programs.mcp = {
    enable = true;
    servers = {
      atlassian = {
        url = "https://mcp.atlassian.com/v1/mcp";
      };
      context7 = npxServer ["-y" "@upstash/context7-mcp"];
      gdrive = {
        command = "/Users/shesselm/go/src/gitlab.com/prodops/mcp-gdrive/.venv/bin/mcp-gdrive";
      };
      gopls = {
        command = "gopls";
        args = ["mcp"];
      };
      kubernetes = npxServer ["-y" "kubernetes-mcp-server" "--config" (toString kubernetesConfig)];
      notion = {
        url = "https://mcp.notion.com/mcp";
      };
      nixos = {
        command = "uvx";
        args = ["mcp-nixos"];
      };
      patternfly = npxServer ["-y" "@patternfly/patternfly-mcp"];
      prowject = {
        command = lib.getExe prowjectPython;
        args = ["${inputs.prowject}/mcp_server.py"];
        env.MCP_TRANSPORT = "stdio";
      };
      rover-search = npxServer ["-y" "git+ssh://git@gitlab.cee.redhat.com/prodops/mcp/mcp-rover-search.git"] // {type = "stdio";};
    };
  };
}
