{ config, lib, pkgs, ... }:
{
  xdg.configFile."python/pythonrc.py".source = config/pythonrc.py;
  home = {
    packages = with pkgs; [
      pyright
      python39Packages.black
      python39Packages.isort
      python39Packages.pipx
    ];
    sessionVariables = {
      PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc.py";
    };
  };
}
