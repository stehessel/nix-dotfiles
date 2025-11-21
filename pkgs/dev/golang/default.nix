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
  };

  programs = {
    go = {
      enable = true;
      env = {
        GOMEMLIMIT = "4GiB";
        GOPROXY = "direct";
      };
    };
  };
}
