{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      delve
      ginkgo
      # golangci-lint
      gopls
      gotest
      gotests
      gotestsum
      richgo
    ];
    sessionPath = [
      "$HOME/${config.programs.go.goPath}/bin"
    ];
  };

  programs = {
    go = {
      enable = true;
      goPath = "go";
      package = pkgs.go_1_18;
    };
  };
}
