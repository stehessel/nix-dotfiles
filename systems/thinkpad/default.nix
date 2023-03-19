_: {
  imports = [
    ../nixos
    ./hardware-configuration.nix
  ];

  boot = {
    initrd = {
      # See https://gist.github.com/ladinu/bfebdd90a5afd45dec811296016b2a3f for a full
      # disk encryption guide for NixOS.
      luks.devices."root" = {
        device = "/dev/disk/by-uuid/c8b25a10-6e4a-4832-af07-10e1d048dfee";
        preLVM = true;
        keyFile = "/keyfile0.bin";
        allowDiscards = true;
      };

      secrets = {
        "keyfile0.bin" = "/etc/secrets/initrd/keyfile0.bin";
      };
    };
  };

  networking.hostName = "thinkpad";
}
