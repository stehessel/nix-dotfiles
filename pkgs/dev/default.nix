{pkgs, ...}: {
  imports = [
    ./ai
    ./build
    ./cue
    ./data
    ./golang
    ./javascript
    ./jsonnet
    ./linux
    ./lua
    ./nix
    ./protobuf
    ./python
    ./rust
    ./sql
    ./text
    ./version-control/git
  ];

  home = {
    packages = with pkgs; [
      semgrep
    ];
  };
}
