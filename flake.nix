{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, neovim-flake }:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = nixpkgs.lib.attrValues self.overlays;
      };
    in
    {
      nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./systems/nixos

          home-manager.nixosModules.home-manager
          (
            { pkgs, ... }:
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.stephan = {
                imports = [
                  ./profiles/stehessel
                  ./roles/linux
                ];
              };
              nixpkgs = nixpkgsConfig;

              users.users = {
                root.hashedPassword = "!";

                stephan = {
                  isNormalUser = true;
                  extraGroups = [ "networkmanager" "wheel" ];
                };
              };
            }
          )
        ];
      };

      darwinConfigurations."shesselm-mac" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./systems/darwin

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.stephan = {
              imports = [
                ./profiles/redhat
                ./roles/work-macos
              ];
            };
            nixpkgs = nixpkgsConfig;

            users.users.stephan = {
              name = "stephan";
              home = "/Users/stephan";
            };
          }
        ];
      };

      overlays = {
        # Fix for https://github.com/NixOS/nixpkgs/issues/165387
        kitty-overlay = final: prev: {
          kitty = prev.kitty.overrideAttrs (old: {
            installCheckPhase = "";
          });
        };

        neovim-overlay = final: prev: {
          inherit (neovim-flake.packages.${ prev.system}) neovim;
        };
      };
    };
}
