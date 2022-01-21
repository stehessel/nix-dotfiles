{ pkgs, lib, ... }:
{
  imports = [
    ../common
    ../../service/calcurse
  ];

  services.mbsync = {
    enable = true;
    configFile = config/mbsync/mbsyncrc;
    frequency = "*:0/1";
  };
  xdg.configFile."mbsync/mbsyncrc".source = config/mbsync/mbsyncrc;

  programs.git = {
    userEmail = "stephan@stehessel.de";
    userName = "stehessel";
  };
}
