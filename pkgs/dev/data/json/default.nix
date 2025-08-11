{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jq
      vscode-langservers-extracted
    ];
  };
}
