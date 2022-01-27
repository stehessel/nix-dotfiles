{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, neovim-nightly-overlay }: {
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
          nixpkgs = {
            overlays = []; # [ neovim-nightly-overlay.overlay ];
          };
          users.users.stephan = {
            name = "stephan";
            home = "/Users/stephan";
          };
        }
      ];
    };

    homeConfigurations = {
      stephan = home-manager.lib.homeManagerConfiguration {
        configuration = {
          imports = [
            ./profiles/stehessel
            ./roles/linux
          ];
          nixpkgs = {
            overlays = [ neovim-nightly-overlay.overlay ];
          };
        };
        homeDirectory = "/home/stephan";
        stateVersion = "22.05";
        username = "stephan";
        system = "x86_64-linux";
      };
    };
  };
}
