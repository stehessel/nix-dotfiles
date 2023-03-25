{
  config,
  pkgs,
  ...
}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock swaylock --ignore-empty-password --daemonize --image ${config.home.homeDirectory}/Sync/backgrounds/samurai_jack_2.png";
      }
    ];
    timeouts = [
      {
        timeout = 60;
        command = "${pkgs.swaylock}/bin/swaylock --ignore-empty-password --daemonize --image ${config.home.homeDirectory}/Sync/backgrounds/samurai_jack_2.png";
      }
    ];
  };
}
