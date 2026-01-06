{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  home = {
    packages = with pkgs;
      [
        age
        auth0-cli
        cosign
        doppler
        sops
        step-ca
        step-cli
        trivy
        vals
      ]
      ++ [pkgs-stable.bitwarden-cli];
    sessionVariables = {
      SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}
