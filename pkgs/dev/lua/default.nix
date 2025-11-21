{pkgs, ...}: {
  imports = [
    ./luacheck
    ./luaformatter
    ./stylua
  ];

  home = {
    packages = with pkgs; [
      lua-language-server
      luajit
      luajitPackages.lua-lsp
      luajitPackages.luacheck
      luajitPackages.luarocks
      selene
      stylua
    ];
    sessionPath = [
      "$HOME/.luarocks/bin"
    ];
  };
}
