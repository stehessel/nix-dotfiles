{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      age
      sops
    ];
  };
}
