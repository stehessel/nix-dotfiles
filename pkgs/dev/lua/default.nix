{pkgs, ...}: {
  imports = [
    ./luacheck
    ./luaformatter
    ./stylua
  ];

  home = {
    packages = with pkgs; [
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
