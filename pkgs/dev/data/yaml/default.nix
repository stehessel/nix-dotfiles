{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      yaml-language-server
      yq-go
    ];
  };
}
