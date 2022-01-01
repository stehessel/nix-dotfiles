{ config, lib, pkgs, ... }:
{
  imports = [
    ../common
  ];

  programs.git = {
    userEmail = "stehessel@redhat.com";
    userName = "Stephan Heßelmann";
  };
}
