{pkgs, ...}: {
  # Login shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Display manager
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
