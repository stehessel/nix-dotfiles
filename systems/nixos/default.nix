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
    timeout = 2;
  };

  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "FiraCode";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  services.printing.enable = true;

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
