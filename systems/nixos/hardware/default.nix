_: {
  fileSystems."/efi" = {
    options = [
      "defaults"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=1"
    ];
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    graphics.enable = true;
  };

  services.fwupd.enable = true;
}
