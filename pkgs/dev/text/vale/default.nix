{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      vale
    ];
    shellAliases = {
      vale = "vale --config=${config.xdg.configHome}/vale/vale.ini";
    };
  };

  xdg.configFile."vale/vale.ini".source = ./config/vale.ini;
}
