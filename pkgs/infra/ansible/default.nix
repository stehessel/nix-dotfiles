{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      ansible
      ansible-lint
      nodePackages."@ansible/ansible-language-server"
    ];
  };
}
