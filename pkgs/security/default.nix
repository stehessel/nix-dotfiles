{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      age
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
