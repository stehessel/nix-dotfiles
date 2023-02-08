{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      age
      bitwarden-cli
      sops
      vals
    ];
    sessionVariables = {
      SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}
