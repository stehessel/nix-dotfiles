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
