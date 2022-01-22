{ pkgs, lib, ... }:
{
  imports = [
    ../common
  ];

  programs.git = {
    userEmail = "shesselm@redhat.com";
    userName = "Stephan Heßelmann";
  };
}
