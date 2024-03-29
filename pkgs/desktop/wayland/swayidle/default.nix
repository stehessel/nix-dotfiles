{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 3000;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
  };
}
