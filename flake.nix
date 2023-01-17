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
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      # Pin to a nixpkgs revision that doesn't have NixOS/nixpkgs#208103 yet
      inputs.nixpkgs.url = "github:NixOS/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
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
      modules = [
        ./systems/nixos
        flakeRegistry
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stephan = {
              imports = [
                ./profiles/stehessel
                ./roles/linux
              ];
            };
          };
          nixpkgs = nixpkgsConfig;

          users.users = {
            root.hashedPassword = "!";

            stephan = {
              isNormalUser = true;
              extraGroups = ["networkmanager" "wheel"];
            };
          };
        }
      ];
    };

    darwinConfigurations.shesselm-mac = inputs.darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./systems/darwin
        flakeRegistry
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stephan = {
              imports = [
                ./profiles/redhat
                ./roles/work-macos
              ];
            };
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
      # bitwarden-cli-overlay = final: prev: {
      #   bitwarden-cli = prev.bitwarden-cli.overrideAttrs (old: {
      #     buildInputs = old.buildInputs ++ [ final.pkgs.makeWrapper ];
      #     postInstall = old.postInstall or "" + ''
      #       wrapProgram "$out/bin/bw" \
      #         --add-flags BW_CLIENTID="$(cat /run/secrets/bitwarden/id || echo)" \
      #         --add-flags BW_CLIENTSECRET="$(cat /run/secrets/bitwarden/secret || echo)"
      #     '';
      #   });
      # };

      kitty-overlay = _: prev: {
        kitty = prev.kitty.overrideAttrs (_: {
          doCheck = false;
        });
      };

      neovim-overlay = _: prev: {
        inherit (inputs.neovim.packages.${prev.system}) neovim;
      };

      neovim-nightly-overlay = inputs.neovim-nightly.overlay;

      rust-overlay = inputs.rust.overlays.default;
    };
  };
}
