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
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations."shesselm-mac" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./configuration.nix ];
    };

    homeConfigurations = {
      stephan = home-manager.lib.homeManagerConfiguration {
        inputs = { inherit nixpkgs; };
        system = "x86_64-darwin";
        homeDirectory = "/Users/stephan";
        username = "stephan";
        configuration.imports = [ /Users/stephan/nix-home/macos.nix ];
      };
    };
  };
}
