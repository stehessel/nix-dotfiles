{
  nixpkgsConfig,
  pkgs,
  ...
}: {
  nixpkgs = nixpkgsConfig;
  nix = {
    extraOptions = ''
      connect-timeout = 5  # in seconds
      experimental-features = ca-derivations nix-command flakes
      fallback = true
      keep-going = true
      log-lines = 25
      max-free = 1000000000 # 1 GB
      min-free = 256000000  # 256 MB
      permittedInsecurePackages = ["nix-2.16.2"];
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    package = pkgs.nixVersions.unstable;
    settings = {
      permittedInsecurePackages = ["nix-2.16.2"];
      auto-optimise-store = true;
      substituters = [
        # Content addressed cache
        # "https://cache.ngi0.nixos.org"
        # See https://nixos.wiki/wiki/Maintainers:Fastly#Cache_v2_plans
        # "https://aseipp-nix-cache.freetls.fastly.net"
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://stehessel.cachix.org"
      ];
      trusted-public-keys = [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      use-xdg-base-directories = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "22.11";
}
