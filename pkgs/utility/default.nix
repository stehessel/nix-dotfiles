{pkgs, ...}: {
  imports = [
    ./broot
    ./fd
    ./fzf
    ./gnupg
    ./pueue
    ./ripgrep
    ./topgrade
    ./wget
    ./zoxide
  ];

  home = {
    packages = with pkgs; [
      ast-grep
      ueberzugpp
    ];
  };
}
