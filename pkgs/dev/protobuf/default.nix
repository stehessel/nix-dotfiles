{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      buf
      buf-language-server
      protolint
    ];
  };
}
