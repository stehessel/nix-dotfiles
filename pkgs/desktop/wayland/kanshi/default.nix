_: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      };
    };
  };
}
