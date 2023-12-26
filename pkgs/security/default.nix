{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      age
      auth0-cli
      bitwarden-cli
      cosign
      sops
      vals
    ];
    sessionVariables = {
      SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}
