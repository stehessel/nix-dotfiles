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
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, neovim-flake }:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = nixpkgs.lib.attrValues self.overlays;
      };
    in
    {
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
            nixpkgs = nixpkgsConfig;
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
            nixpkgs = nixpkgsConfig;
          };
          homeDirectory = "/home/stephan";
          stateVersion = "22.05";
          username = "stephan";
          system = "x86_64-linux";
        };
      };

      overlays = {
        fish-overlay = final: prev: {
          fish = prev.fish.overrideAttrs (old: {
            doCheck = false;
          });
        };

        httpie-overlay = final: prev: {
          httpie = prev.httpie.overrideAttrs (old: {
            disabledTests = old.disabledTests ++ [ "test_plugins_upgrade" "test_uploads" ];
          });
        };

        kitty-overlay = final: prev: {
          kitty = prev.kitty.overrideAttrs (old: {
            installCheckPhase = "";
          });
        };

        libjxl-overlay = final: prev: {
          libjxl = prev.libjxl.overrideAttrs (old: {
            doCheck = false;
          });
        };

        python-overlay = final: prev: rec {
          python3 = prev.python3.override {
            packageOverrides = final: prev: {
              jxmlease = prev.jxmlease.overridePythonAttrs (old: {
                doCheck = false;
                installCheckPhase = "";
              });

              requests = prev.requests.overridePythonAttrs (old: {
                pytestFlagsArray = [ "tests/test_help.py" ];
              });

              sh = prev.sh.overridePythonAttrs (old: {
                doCheck = false;
                installCheckPhase = "";
              });
            };
          };
          python3Packages = python3.pkgs;
        };

        neovim-overlay = final: prev: {
          inherit (neovim-flake.packages.${ prev.system}) neovim;
        };
      };
    };
}
