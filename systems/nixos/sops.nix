{ config, sops, ... }:
{
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
      "ssh/hcloud_k8s/public" = {
        path = "/etc/ssh/ssh_hcloud_k8s_key.pub";
        sopsFile = ../../secrets/ssh.yaml;
        owner = config.users.users.stephan.name;
        inherit (config.users.users.stephan.group);
      };
      "ssh/hcloud_k8s/private" = {
        path = "/etc/ssh/ssh_hcloud_k8s_key";
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
