{ config, lib, pkgs, ... }:
{
  home.file."git/raq/.vimspector.json".source = config/raq.json;
  home.file."git/.vimspector.json".source = config/default.json;
  home.file."dev/.vimspector.json".source = config/default.json;
}
