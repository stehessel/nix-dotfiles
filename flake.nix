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
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
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
        inputs.hyprland.nixosModules.default
        {programs.hyprland.enable = true;}
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stephan = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.hyprland.homeManagerModules.default
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
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stephan = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
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

      buf-overlay = _: prev: {
        buf = prev.buf.overrideAttrs (_: {
          doCheck = false;
        });
      };

      kitty-overlay = _: prev: {
        kitty = prev.kitty.overrideAttrs (_: {
          doCheck = false;
        });
      };

      neovim-nightly-overlay = inputs.neovim-nightly.overlay;

      python-overlay = _: prev: rec {
        python3 = prev.python3.override {
          packageOverrides = _: prev: {
            httpcore = prev.httpcore.overridePythonAttrs (_: {
              doCheck = false;
              installCheckPhase = "";
            });
          };
        };
        python3Packages = python3.pkgs;
      };

      rust-overlay = inputs.rust.overlays.default;
    };
  };
}
