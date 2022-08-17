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
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
          inputs.sops-nix.nixosModules.sops

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
          inputs.sops-nix.nixosModules.sops

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
        # bitwarden-cli-overlay = final: prev: {
        #   bitwarden-cli = prev.bitwarden-cli.overrideAttrs (old: {
        #     buildInputs = old.buildInputs ++ [ final.pkgs.makeWrapper ];
        #     postInstall = old.postInstall or "" + ''
        #       wrapProgram "$out/bin/bitwarden-cli" --set BW_CLIENTID "$(cat /run/secrets/bitwarden/id)" --set BW_CLIENTSECRET "$(cat /run/secrets/bitwarden/secret)"
        #     '';
        #   });
        # };

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

        python-overlay = final: prev: rec {
          python3 = prev.python3.override {
            packageOverrides = final: prev: {
              mocket = prev.mocket.overridePythonAttrs (old: {
                disabledTests = old.disabledTests ++ [ "test_gethostbyname" ];
              });
            };
          };
          python3Packages = python3.pkgs;
        };

        rust-overlay = inputs.rust.overlays.default;
      };
    };
}
