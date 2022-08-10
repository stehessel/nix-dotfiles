{ config, lib, pkgs, ... }:
{
  imports = [
    ./aws
    ./azure
    ./gcp
  ];
}
