{pkgs, ...}: {
  imports = [
    ./luacheck
    ./luaformatter
    ./stylua
  ];

  home = {
    packages = with pkgs; [
      luajit
      luajitPackages.lua-lsp
      luajitPackages.luacheck
      luajitPackages.luarocks
      selene
      stylua
      sumneko-lua-language-server
    ];
    sessionPath = [
      "$HOME/.luarocks/bin"
    ];
  };
}
