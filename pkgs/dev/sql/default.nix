{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      nodePackages.sql-formatter
      sqlite
    ];
  };
}
