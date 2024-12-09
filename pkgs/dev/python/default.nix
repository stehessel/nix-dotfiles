{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./flake8
    ./isort
    ./mypy
    ./pycodestyle
  ];

  xdg.configFile."python/pythonrc.py".source = config/pythonrc.py;
  home = {
    packages = with pkgs; [
      black
      pipx
      pyright
      ruff
      uv
    ];
    sessionVariables = {
      PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc.py";
    };
  };
}
