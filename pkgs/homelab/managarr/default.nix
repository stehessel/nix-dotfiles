{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      managarr
    ];
  };
  sops.templates."managarr".content = ''
    theme: default
    radarr:
      - uri: https://stehessel.gandalf.usbx.me/radarr
        api_token: "${config.sops.placeholder."radarr/token"}"
    sonarr:
      - uri: https://stehessel.gandalf.usbx.me/sonarr
        api_token: "${config.sops.placeholder."sonarr/token"}"
  '';
  xdg.configFile."managarr/config.yml".source = config.lib.file.mkOutOfStoreSymlink config.sops.templates."managarr".path;
}
