{pkgs, ...}: {
  # Login shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland --remember --time";
        user = "greeter";
      };
    };
  };
}
