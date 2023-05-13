{
  lib,
  pkgs,
  ...
}: {
  security = {
    audit.enable = true;
    auditd.enable = true;
    pam.services.swaylock = {};
    sudo.execWheelOnly = true;
  };

  # Firejail doesn't work with home-manager for the moment.
  programs.firefox.enable = true;

  # Causes chromium rebuild, which takes forever.
  # security.chromiumSuidSandbox.enable = true;

  programs.firejail = {
    enable = false;
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    };
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Antivirus
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
