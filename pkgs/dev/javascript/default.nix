{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      eslint_d
      nodejs
      prettier
      prettierd
      tailwindcss-language-server
      typescript
      typescript-language-server
      yarn
    ];
    sessionPath = [
      "${config.xdg.configHome}/npm/npm-packages/bin"
    ];
    sessionVariables = {
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";
    };
    shellAliases = {
      yarn = "yarn --use-yarnrc ${config.xdg.configHome}/yarn/config";
    };
  };
  xdg.configFile."npm/config".source = config/npmrc;
  xdg.configFile."yarn/config".source = config/yarnrc;
}
