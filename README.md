# nix-dotfiles

Personal dotfiles based on Nix flakes and home manager.

## Configurations

* My personal laptop `nixosConfigurations.thinkpad`.
* My company laptop `nixosConfigurations.shesselm-mac`.

## Usage

Switch to a new NixOS generation via

```
nixos-rebuild switch --flake . --use-remote-sudo
```

Switch to a new Darwin generation via

```
darwin-rebuild switch --flake .
```
