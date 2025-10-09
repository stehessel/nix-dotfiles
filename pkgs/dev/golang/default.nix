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
      GOMEMLIMIT = "4GiB";
      GOROOT = "$HOME/go";
    };
  };

  programs = {
    go = {
      enable = true;
    };
  };
}
