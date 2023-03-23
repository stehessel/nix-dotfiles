{
  lib,
  pkgs,
  ...
}: {
  security = {
    sudo.execWheelOnly = true;
  };

  # The `scudo` memory allocator set by the hardened profile is causing instability problems.
  # Switch back to default `libc` allocator.
  environment.memoryAllocator.provider = "libc";

  # Firejail doesn't work with home-manager for the moment.
  programs.firefox.enable = true;

  # Causes chromium rebuild, which takes forever.
  # security.chromiumSuidSandbox.enable = true;

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    };
  };
}
