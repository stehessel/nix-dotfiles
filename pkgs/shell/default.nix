{pkgs, ...}: {
  imports = [
    ./bash
    ./fish
    ./nushell
    ./starship
  ];
  home = {
    packages = with pkgs; [
      bash-language-server
      bashInteractive
      dash
      elvish
      shellcheck
      shfmt
    ];
  };
}
