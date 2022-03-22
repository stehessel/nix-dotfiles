{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  # Networking
  networking = {
    hostName = "thinkpad";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;
  };
  programs.nm-applet.enable = true;

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "FiraCode";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  services = {
    printing.enable = true;
    tlp.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Login shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Autostart window manager
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      export XKB_DEFAULT_OPTIONS="caps:escape"
      exec river
    fi
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "22.05";
}
