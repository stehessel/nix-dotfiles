{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rustup
      rust-analyzer
    ];
    sessionPath = [
      "${config.xdg.configHome}/cargo/bin"
    ];
    sessionVariables = {
      CARGO_HOME = "${config.xdg.configHome}/cargo";
      RUSTUP_HOME = "${config.xdg.configHome}/rustup";
    };
  };

  xdg.configFile."cargo/config.toml".source = config/cargo/config.toml;
}
