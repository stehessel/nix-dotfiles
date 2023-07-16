{
  # config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      jq
      nodePackages.vscode-langservers-extracted
      yq-go
    ];
    # sessionVariables = {
    #   PRETTIERD_DEFAULT_CONFIG = "${config.xdg.configHome}/prettier/prettierrc.json";
    # };
  };
  # xdg.configFile."prettier/prettierrc.json".source = ./config/prettierrc.json;
}
