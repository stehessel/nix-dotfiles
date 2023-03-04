{
  config,
  xdg,
  ...
}: {
  sops = {
    defaultSopsFile = ./shared.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      # "bitwarden/id" = {
      #   mode = "0400";
      # };
      # "bitwarden/secret" = {
      #   mode = "0400";
      # };
      # "cachix/token" = {
      #   mode = "0400";
      # };
      # "github/fluxcd/user" = {
      #   mode = "0400";
      # };
      # "github/fluxcd/token" = {
      #   mode = "0400";
      # };

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
