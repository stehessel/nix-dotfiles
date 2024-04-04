{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # We only have this input to pass it to other dependencies and
    # avoid having multiple versions in our dependencies.
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stehessel = {
      url = "github:stehessel/nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust";
      };
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }: let
    overlays = {
      stehessel-overlay = inputs.stehessel.overlays.default;
      rust-overlay = inputs.rust.overlays.default;

      # k9s-overlay = _: prev: {
      #   k9s = prev.k9s.overrideAttrs (_: {
      #     doCheck = false;
      #   });
      # };

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
    nixpkgsConfig = {
      config.allowUnfree = true;
      overlays = inputs.nixpkgs.lib.attrValues overlays;
    };
    flakeRegistry = {
      nix.registry.nixpkgs.flake = inputs.nixpkgs;
      nix.registry.stehessel.flake = self;
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;}
    ({withSystem, ...}: {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            config.pre-commit.devShell
          ];
        };

        pre-commit.settings.imports = [./nix/pre-commit.nix];
      };

      flake = {
        nixosConfigurations.thinkpad = withSystem "x86_64-linux" (
          _:
            inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs nixpkgsConfig;
              };
              modules = [
                {nixpkgs = nixpkgsConfig;}
                inputs.lanzaboote.nixosModules.lanzaboote
                ./systems/thinkpad
                flakeRegistry
                {programs.hyprland.enable = true;}
                inputs.nix-index-database.nixosModules.nix-index
                inputs.home-manager.nixosModules.home-manager
              ];
            }
        );

        darwinConfigurations.shesselm-mac = withSystem "x86_64-darwin" (
          _:
            inputs.darwin.lib.darwinSystem {
              system = "x86_64-darwin";
              specialArgs = {
                inherit inputs nixpkgsConfig;
              };
              modules = [
                {nixpkgs = nixpkgsConfig;}
                ./systems/darwin
                flakeRegistry
                inputs.nix-index-database.darwinModules.nix-index
                inputs.home-manager.darwinModules.home-manager
              ];
            }
        );
      };
    });
}
