{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      go-jsonnet
      jsonnet-bundler
      jsonnet-language-server
    ];
  };
}
