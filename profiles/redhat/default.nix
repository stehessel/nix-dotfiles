{ config, lib, pkgs, ... }:
{
  imports = [
    ../common
  ];

  programs.git = {
    userEmail = "shesselm@redhat.com";
    userName = "Stephan Heßelmann";
  };
  home.sessionPath = [
    "$HOME/${config.programs.go.goPath}/src/github.com/stackrox/workflow/bin"
  ];
}
