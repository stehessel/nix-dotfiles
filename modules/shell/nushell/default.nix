{ lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    settings = {
      edit_mode = "nvim";
      prompt = "starship prompt";
      startup = [
        "alias la [] { ls -a }"
        "alias e [msg] { echo $msg }"
      ];
    };
  };
}
