{
  llms,
  pkgs,
  ...
}: let
  ha-mcp = pkgs.writeShellScript "ha-mcp" ''
    export HOMEASSISTANT_URL="https://home.stephan.sh"
    export HOMEASSISTANT_TOKEN=$(${pkgs.spire}/bin/spire-agent api fetch jwt \
      -audience homeassistant-proxy \
      -socketPath /tmp/spire-agent/public/api.sock \
      -format json 2>/dev/null | ${pkgs.jq}/bin/jq -r '.[0].svids[0].svid')
    exec ${pkgs.uv}/bin/uvx --from ha-mcp@latest ha-mcp
  '';
in {
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
      # home-assistant = {
      #   command = toString ha-mcp;
      # };
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
