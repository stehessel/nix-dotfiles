{config, ...}: {
  sops = {
    defaultSopsFile = ./shared.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      "cachix/token" = {
        path = "${config.home.homeDirectory}/dev/secrets/cachix/token";
      };
      "ssh/github/public" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/github.pub";
        sopsFile = ./ssh.yaml;
      };
      "ssh/github/private" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/github";
        sopsFile = ./ssh.yaml;
      };
      "ssh/hcloud/public" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/hcloud.pub";
        sopsFile = ./ssh.yaml;
      };
      "ssh/hcloud/private" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/hcloud";
        sopsFile = ./ssh.yaml;
      };
      "ssh/seedbox/public" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/seedbox.pub";
        sopsFile = ./ssh.yaml;
      };
      "ssh/seedbox/private" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/seedbox";
        sopsFile = ./ssh.yaml;
      };
      "ssh/server/public" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/server.pub";
        sopsFile = ./ssh.yaml;
      };
      "ssh/server/private" = {
        path = "${config.home.homeDirectory}/dev/secrets/ssh/server";
        sopsFile = ./ssh.yaml;
      };
    };
  };
}
