{
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
        antigravity-cli
        beans
        openshell
      ])
      (with llms; [
        apm
        beads
        beads-viewer
        coderabbit-cli
        kilocode-cli
        nono
        pi
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
        # Webhook URL is guarded by Home Assistant OAuth login (ha_auth).
        url = "https://home.stephan.sh/api/webhook/mcp_841baf20d12fbd58fc207f24464f2a19";
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
}
