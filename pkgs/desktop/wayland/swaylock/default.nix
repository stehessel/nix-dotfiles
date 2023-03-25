{config, ...}: {
  programs = {
    swaylock = {
      settings = {
        daemonize = true;
        ignore-empty-password = true;
        image = "${config.home.homeDirectory}/Sync/backgrounds/samurai_jack_2.png";
      };
    };
  };
}
