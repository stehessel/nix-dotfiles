{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      delve
      ginkgo
      gofumpt
      golangci-lint
      gopls
      gotest
      gotests
      gotestsum
      richgo
    ];
    sessionPath = [
      "$HOME/${config.programs.go.goPath}/bin"
    ];
    sessionVariables = {
      GOMEMLIMIT = "8Gi";
    };
  };

  programs = {
    go = {
      enable = true;
      goPath = "go";
    };
  };
}
