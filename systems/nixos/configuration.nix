# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
    # See https://gist.github.com/ladinu/bfebdd90a5afd45dec811296016b2a3f for the LUKS setup.
    initrd = {
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

  networking = {
    hostName = "thinkpad";
    networkmanager.enable = true;
  };

  users.users.stephan = {
    isNormalUser = true;
    home = "/home/stephan";
    extraGroups = ["wheel" "networkmanager"];
  };

  environment.systemPackages = with pkgs; [
    bitwarden-cli
    git
    neovim
  ];

  system.stateVersion = "22.11";
}
