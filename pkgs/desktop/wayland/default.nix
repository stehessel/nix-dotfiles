{pkgs, ...}: {
  imports = [
    ./hyprland
    ./kanshi
    ./swayidle
    ./swaylock
    ./waybar
  ];

  home = {
    packages = with pkgs; [
      swaybg
    ];
  };
}
