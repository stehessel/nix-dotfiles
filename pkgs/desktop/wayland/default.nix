{pkgs, ...}: {
  imports = [
    ./hyprland
    ./swayidle
    ./waybar
  ];

  home = {
    packages = with pkgs; [
      swaybg
      swaylock
    ];
  };
}
