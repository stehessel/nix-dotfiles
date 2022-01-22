{ pkgs, lib, ... }:
{
  xdg.configFile = {
    "systemd/user/calcurse.timer".source = config/calcurse.timer;
    "systemd/user/calcurse.service".source = config/calcurse.service;
  };
}
