{
  description = "Nix system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    cc-skills-golang = {
      url = "github:samber/cc-skills-golang";
      flake = false;
    };
    ponytail = {
      url = "github:DietrichGebert/ponytail";
      flake = false;
    };
    prowject = {
      url = "github:redhat-community-ai-tools/prowject";
      flake = false;
    };
    supabase-agent-skills = {
      url = "github:supabase/agent-skills";
      flake = false;
    };
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
    stehessel = {
      url = "github:stehessel/nix-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust";
      };
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
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

  outputs = inputs: let
    overlays = {
      stehessel-overlay = inputs.stehessel.overlays.default;
      rust-overlay = inputs.rust.overlays.default;

      # Overlay examples.

      # kitty-overlay = _: prev: {
      #   kitty = prev.kitty.overrideAttrs (_: {
      #     doCheck = false;
      #   });
      # };

      semgrep-overlay = _: prev: {
        semgrep = prev.semgrep.overridePythonAttrs (_: {
          doCheck = false;
        });
      };
    };
    nixpkgsConfig = {
      config.allowUnfree = true;
      overlays = inputs.nixpkgs.lib.attrValues overlays;
    };
    flakeRegistry = {
      nixpkgs.flake = inputs.nixpkgs;
      stehessel.flake = inputs.self;
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (_: {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [
        inputs.git-hooks.flakeModule
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
        nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs nixpkgsConfig;
            llms = inputs.llm-agents.packages.${system};
            pkgs-stable = import inputs.nixpkgs-stable {inherit system;};
          };
          modules = [
            {nixpkgs = nixpkgsConfig;}
            inputs.lanzaboote.nixosModules.lanzaboote
            ./systems/thinkpad
            {nix.registry = flakeRegistry;}
            {programs.hyprland.enable = true;}
            inputs.nix-index-database.nixosModules.nix-index
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        darwinConfigurations.shesselm-mac = inputs.darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs nixpkgsConfig;
            llms = inputs.llm-agents.packages.${system};
            pkgs-stable = import inputs.nixpkgs-stable {inherit system;};
          };
          modules = [
            {nixpkgs = nixpkgsConfig;}
            ./systems/darwin
            inputs.determinate.darwinModules.default
            {determinateNix.registry = flakeRegistry;}
            inputs.nix-index-database.darwinModules.nix-index
            inputs.home-manager.darwinModules.home-manager
            inputs.nix-homebrew.darwinModules.nix-homebrew
          ];
        };
      };
    });
}
