{ pkgs, lib, ... }:
{
  home.file."python/config".source = config/pythonrc;
}
