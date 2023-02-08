{
  config,
  xdg,
  ...
}: {
  sops = {
    defaultSopsFile = ./shared.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      "bitwarden/id" = {
        mode = "0400";
      };
      "bitwarden/secret" = {
        mode = "0400";
      };
      "cachix/token" = {
        mode = "0400";
      };
      "github/fluxcd/user" = {
        mode = "0400";
      };
      "github/fluxcd/token" = {
        mode = "0400";
      };

      "ssh/github/public" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
      "ssh/github/private" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
      "ssh/hcloud/public" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
      "ssh/hcloud/private" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
      "ssh/server/public" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
      "ssh/server/private" = {
        mode = "0400";
        sopsFile = ./ssh.yaml;
      };
    };
  };
}
