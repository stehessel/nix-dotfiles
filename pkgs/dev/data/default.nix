_: {
  imports = [
    ./json
    ./toml
    ./yaml
  ];
  home = {
    # sessionVariables = {
    #   PRETTIERD_DEFAULT_CONFIG = "${config.xdg.configHome}/prettier/prettierrc.json";
    # };
  };
  # xdg.configFile."prettier/prettierrc.json".source = ./config/prettierrc.json;
}
