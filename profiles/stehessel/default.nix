{ lib, pkgs, ... }:
{
  imports = [
    ../common
    ../../services/calcurse
  ];

  accounts.email.accounts = {
    stehessel = {
      primary = true;
      himalaya.enable = true;
      address = "stephan@stehessel.de";
      realName = "Stephan Heßelmann";
      userName = "stephan@stehessel.de";
      passwordCommand = "bw get password 0ced5d86-5922-455a-81a2-aac4013f97b6";
      imap = {
        host = "imap.mailbox.org";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.mailbox.org";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
    };
  };
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
