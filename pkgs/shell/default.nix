{pkgs, ...}: {
  imports = [
    ./bash
    ./fish
    ./nushell
    ./starship
  ];
  home = {
    packages = with pkgs; [
      bashInteractive
      dash
      elvish
      # nodePackages.bash-language-server
      shellcheck
      shfmt
    ];
  };
}
