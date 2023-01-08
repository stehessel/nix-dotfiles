{pkgs, ...}: {
  home = let
    python-packages = ps: [ps.pynvim];
    neovim-python = pkgs.python3.withPackages python-packages;
  in {
    packages = with pkgs; [
      neovim
      neovim-python
    ];

    sessionVariables = {
      NVIM_PYTHON_PROVIDER = "${neovim-python.out}/bin/python";
    };
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
