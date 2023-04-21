{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jq
      nodePackages.vscode-langservers-extracted
      yq-go
    ];
  };
}
