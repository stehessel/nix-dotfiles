{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../services/calcurse
  ];

  programs = {
    git = {
      userEmail = "stephan@stehessel.de";
      userName = "stehessel";
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "server" = {
          addressFamily = "inet";
          hostname = "hesselmann.cloud";
          identitiesOnly = true;
          identityFile = "~/.ssh/stehessel-server.pub";
          port = 50022;
          user = "stephan";
        };
      };
    };
  };
  services.mbsync = {
    enable = false;
    configFile = config/mbsync/mbsyncrc;
    frequency = "*:0/1";
  };
  xdg.configFile."mbsync/mbsyncrc".source = config/mbsync/mbsyncrc;
}
