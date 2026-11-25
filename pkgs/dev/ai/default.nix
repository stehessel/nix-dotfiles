{
  llms,
  pkgs,
  ...
}: {
  imports = [
    ./claude
    ./codex
    ./mcp
    ./opencode
    ./pi
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
        herdr
        herdr-app
        # kilocode-cli
        nono
      ])
    ];
  };
}
