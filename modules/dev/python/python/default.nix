{ lib, pkgs, ... }:
{
  home = {
    file."python/config".source = config/pythonrc;

    packages = with pkgs; [
      pyright
      python39Packages.black
      python39Packages.isort
      python39Packages.pipx
    ];
  };
}
