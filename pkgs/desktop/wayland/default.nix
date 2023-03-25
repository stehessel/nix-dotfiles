{pkgs, ...}: {
  imports = [
    ./hyprland
    ./waybar
  ];

  home = {
    packages = with pkgs; [
      swaybg
      swayidle
      swaylock
    ];
  };
}
