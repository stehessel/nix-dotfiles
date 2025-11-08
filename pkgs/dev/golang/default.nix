{pkgs, ...}: {
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
      "$HOME/go/bin"
    ];
    sessionVariables = {
      GOMEMLIMIT = "4GiB";
      GOPROXY = "direct";
    };
  };

  programs = {
    go = {
      enable = true;
    };
  };
}
