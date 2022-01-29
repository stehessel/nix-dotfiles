{ config, lib, pkgs, ... }:
{
  home = {
    sessionPath = [
      "${config.xdg.configHome}/npm/npm-packages/bin"
    ];
    sessionVariables = {
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      NPM_CONFIG_TMP = "$TMPDIR/npm";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";
    };
  };
  xdg.configFile."npm/config".source = config/npmrc;
}
