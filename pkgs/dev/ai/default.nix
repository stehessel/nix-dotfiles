{pkgs, ...}: {
  imports = [
    ./claude
    # ./sourcery
  ];

  home = {
    packages = with pkgs; [
      beans
      beads
    ];
  };
}
