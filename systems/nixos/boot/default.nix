{
  lib,
  pkgs,
  ...
}: {
  boot = rec {
    # Enable only bootspec before enabling lanzaboote on initial setup of secure boot.
    # See https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    bootspec.enable = true;

    initrd.systemd.enable = true;

    kernel.sysctl = {
      # Disable magic SysRq key. See https://blastrock.github.io/fde-tpm-sb.html.
      "kernel.sysrq" = 0;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };

      systemd-boot = {
        # Lanzaboote currently replaces the systemd-boot module.
        # This setting is usually set to true in configuration.nix
        # generated at installation time. So we force it to false
        # for now.
        enable =
          if lanzaboote.enable
          then lib.mkForce false
          else true;
        configurationLimit = 15;
      };

      timeout = 1;
    };
  };

  # Secure boot key manager
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
