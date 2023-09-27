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
      "acme/zeroSSL/eabKid" = {
        path = "${config.home.homeDirectory}/dev/secrets/acme/zeroSSL/kid";
      };
      "acme/zeroSSL/eabHmacKey" = {
        path = "${config.home.homeDirectory}/dev/secrets/acme/zeroSSL/key";
      };
      "aws/dev/accessKeyId" = {
        path = "${config.home.homeDirectory}/dev/secrets/aws/dev/accessKeyId";
      };
      "aws/dev/accountId" = {
        path = "${config.home.homeDirectory}/dev/secrets/aws/dev/accountId";
      };
      "aws/dev/secretAccessKey" = {
        path = "${config.home.homeDirectory}/dev/secrets/aws/dev/secretAccessKey";
      };
      "docker/stehessel/user" = {
        path = "${config.home.homeDirectory}/dev/secrets/docker/user";
      };
      "docker/stehessel/password" = {
        path = "${config.home.homeDirectory}/dev/secrets/docker/password";
      };
      "openshift/pullSecret" = {
        path = "${config.home.homeDirectory}/dev/secrets/openshift/pullSecret";
      };
      "quay.io/stehessel/user" = {
        path = "${config.home.homeDirectory}/dev/secrets/quay.io/user";
      };
      "quay.io/stehessel/password" = {
        path = "${config.home.homeDirectory}/dev/secrets/quay.io/password";
      };
      "infractl/token" = {
        path = "${config.home.homeDirectory}/dev/secrets/infractl/token";
      };
      "jira/token" = {
        path = "${config.home.homeDirectory}/dev/secrets/jira/token";
      };
    };
  };
}
