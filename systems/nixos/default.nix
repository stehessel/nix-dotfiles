{pkgs, ...}: {
  imports = [
    ./boot
    ./hardware
    ./login
    ./networking
    ./nix
  ];

  systemd.coredump.enable = false;

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "FiraCode";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = ["FiraCode"];
    })
  ];

  services = {
    printing.enable = true;
    tlp.enable = true;
  };

  # Memory
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid '^(wayland|hyprland|kitty|foot)$'"
      "--prefer '^(electron|libreoffice|gimp|brave)$'"
    ];
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Screen share
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement.
      dockerCompat = true;
    };
  };
}
