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
        ./systems/darwin/configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stephan = ./systems/darwin;

          nixpkgs = {
            overlays = [ neovim-nightly-overlay.overlay ];
          };
        }
      ];
    };
  };
}
