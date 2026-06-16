{
  llms,
  pkgs,
  ...
}: {
  imports = [
    ./claude
    # ./sourcery
  ];

  home = {
    packages = builtins.concatLists [
      (with pkgs; [
        beans
        opencode
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
}
