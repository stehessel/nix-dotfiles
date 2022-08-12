{ config, sops, ... }:
{
  sops.defaultSopsFile = ../../secrets/shared.yaml;
  sops.age.keyFile = "/home/stephan/.config/sops/age/keys.txt";
  sops.secrets.example-key = { };
  sops.secrets."myservice/my_subdir/my_secret" = { };
  sops.secrets."ssh/github/public" = {
    path = "/etc/ssh/ssh_github_key.pub";
    sopsFile = ../../secrets/ssh.yaml;
    owner = config.users.users.stephan.name;
    inherit (config.users.users.stephan.group);
  };
  sops.secrets."ssh/github/private" = {
    path = "/etc/ssh/ssh_github_key";
    sopsFile = ../../secrets/ssh.yaml;
    owner = config.users.users.stephan.name;
    inherit (config.users.users.stephan.group);
  };
  sops.secrets."ssh/server/public" = {
    path = "/etc/ssh/ssh_server_key.pub";
    sopsFile = ../../secrets/ssh.yaml;
    owner = config.users.users.stephan.name;
    inherit (config.users.users.stephan.group);
  };
  sops.secrets."ssh/server/private" = {
    path = "/etc/ssh/ssh_server_key";
    sopsFile = ../../secrets/ssh.yaml;
    owner = config.users.users.stephan.name;
    inherit (config.users.users.stephan.group);
  };
}
