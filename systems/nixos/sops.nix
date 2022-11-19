{
  config,
  sops,
  ...
}: {
  sops = {
    defaultSopsFile = ../../secrets/shared.yaml;
    age.keyFile = "/home/${config.users.users.stephan.name}/.config/sops/age/keys.txt";
    secrets = {
      "bitwarden/id" = {
        sopsFile = ../../secrets/shared.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "bitwarden/secret" = {
        sopsFile = ../../secrets/shared.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "cachix/token" = {
        sopsFile = ../../secrets/shared.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "github/fluxcd/user" = {
        sopsFile = ../../secrets/shared.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "github/fluxcd/token" = {
        sopsFile = ../../secrets/shared.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };

      "ssh/github/public" = {
        path = "/etc/ssh/ssh_github_key.pub";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/github/private" = {
        path = "/etc/ssh/ssh_github_key";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/hcloud/public" = {
        path = "/etc/ssh/ssh_hcloud_key.pub";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/hcloud/private" = {
        path = "/etc/ssh/ssh_hcloud_key";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/server/public" = {
        path = "/etc/ssh/ssh_server_key.pub";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/server/private" = {
        path = "/etc/ssh/ssh_server_key";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
    };
  };
}
