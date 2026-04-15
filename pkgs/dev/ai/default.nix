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
      (with pkgs; [beans beads])
      (with llms; [apm beads-viewer coderabbit-cli])
    ];
  };
}
