{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      backblaze-b2
    ];
  };
}
