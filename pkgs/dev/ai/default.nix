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
      gopls = {
        command = "gopls";
        args = ["mcp"];
      };
      nixos = {
        command = "uvx";
        args = ["mcp-nixos"];
      };
    };
  };
}
