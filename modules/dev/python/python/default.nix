{ lib, pkgs, ... }:
{
  home.file."python/config".source = config/pythonrc;
}
