{pkgs, ...}: {
  # Login shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Login manager
  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin = {
        enable = false;
        user = "stephan";
      };
      defaultSession = "hyprland";
      lightdm.enable = true;
    };
    libinput.enable = true;
  };
}
