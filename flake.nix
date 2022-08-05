{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs.url = "path:/home/stephan/dev/nix/nixpkgs";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "path:/home/stephan/dev/nix/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          # contentAddressedByDefault = true;
        };
        overlays = nixpkgs.lib.attrValues self.overlays;
      };
    in
    {
      nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./systems/nixos

          inputs.home-manager.nixosModules.home-manager
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

      darwinConfigurations."shesselm-mac" = inputs.darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./systems/darwin

          inputs.home-manager.darwinModules.home-manager
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
        git-town-overlay = final: prev: {
          git-town = prev.git-town.overrideAttrs (old: {
            doCheck = false;
          });
        };

        kitty-overlay = final: prev: {
          kitty = prev.kitty.overrideAttrs (old: {
            installCheckPhase = "";
          });
        };

        neovim-overlay = final: prev: {
          inherit (inputs.neovim.packages.${ prev.system}) neovim;
        };

        rust-overlay = inputs.rust.overlays.default;
      };
    };
}
