{
  imports = [./ha-mcp];

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
      notion = {
        url = "https://mcp.notion.com/mcp";
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
