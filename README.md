# nix-dotfiles

Personal dotfiles based on Nix flakes and home manager.

# Configurations

* My personal laptop `nixosConfigurations.thinkpad`.
* My company laptop `nixosConfigurations.shesselm-mac`.

# Usage

## NixOS

Switch to a new NixOS generation via

```
nixos-rebuild switch --flake . --use-remote-sudo
```

### Installation

* Copy `./systems/nixos/configuration.nix` to `/etc/nixos/configuration.nix` to gain access to `git` and `bitwarden`.
* Use `bitwarden` to set up `SOPS` keys.
* Create a new entry in `./systems`:
  - Create entries for the LUKS partitions.
  - Copy the hardware configuration.
* Switch to a new generation defined by the flake.

## Darwin

Switch to a new Darwin generation via

```
darwin-rebuild switch --flake .
```
