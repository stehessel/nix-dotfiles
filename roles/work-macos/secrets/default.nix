{config, ...}: {
  sops = {
    defaultSopsFile = ./sops.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      "bitwarden/api/id" = {
        path = "${config.home.homeDirectory}/dev/secrets/bitwarden/id";
      };
      "bitwarden/api/secret" = {
        path = "${config.home.homeDirectory}/dev/secrets/bitwarden/secret";
      };
    };
  };
}
