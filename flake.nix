{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stehessel-overlay = {
      url = "github:stehessel/nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
        # contentAddressedByDefault = true;
      };
      overlays = nixpkgs.lib.attrValues self.overlays;
    };
    flakeRegistry = {
      nix.registry.nixpkgs.flake = nixpkgs;
      nix.registry.stehessel.flake = self;
    };
  in {
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit nixpkgsConfig;
      };
      modules = [
        inputs.lanzaboote.nixosModules.lanzaboote
        ./systems/thinkpad
        flakeRegistry
        inputs.hyprland.nixosModules.default
        {programs.hyprland.enable = true;}
        inputs.nix-index-database.nixosModules.nix-index
        inputs.home-manager.nixosModules.home-manager
      ];
    };

    darwinConfigurations.shesselm-mac = inputs.darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      specialArgs = {
        inherit inputs;
        inherit nixpkgsConfig;
      };
      modules = [
        ./systems/darwin
        flakeRegistry
        inputs.nix-index-database.darwinModules.nix-index
        inputs.home-manager.darwinModules.home-manager
      ];
    };

    overlays = {
      stehessel-overlay = inputs.stehessel-overlay.overlay;
      rust-overlay = inputs.rust.overlays.default;

      k9s-overlay = _: prev: {
        k9s = prev.k9s.overrideAttrs (_: {
          doCheck = false;
        });
      };

      # python-overlay = _: prev: rec {
      #   python3 = prev.python3.override {
      #     packageOverrides = _: prev: {
      #       pytest-httpserver = prev.pytest-httpserver.overridePythonAttrs (_: {
      #         doCheck = false;
      #       });
      #     };
      #   };
      #   python3Packages = python3.pkgs;
      # };
    };
  };
}
