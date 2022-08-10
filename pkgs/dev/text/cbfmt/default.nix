{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      cbfmt
    ];
    shellAliases = {
      cbfmt = "cbfmt --config=${config.xdg.configHome}/cbfmt/cbfmt.toml";
    };
  };

  xdg.configFile."cbfmt/cbfmt.toml".source = ./config/cbfmt.toml;
}
