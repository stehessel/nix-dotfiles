{ lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "river/tags"
          "custom/right-arrow-dark"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "backlight"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "battery"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];

        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-light" = {
          format = "";
          tooltip = false;
        };

        "river/tags" = {
          "num-tags" = 8;
          "tag-labels" = [ "1" "2" "3" "4" "5" "6" "7" "8" ];
        };

        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };
        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#3" = {
          format = "{:%G-%m-%d}";
          tooltip = false;
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent:2}%";
          format-icons = [ "" "" ];
        };
        puiseaudio = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };
        memory = {
          interval = 5;
          format = "Mem {}%";
        };
        cpu = {
          interval = 5;
          format = "CPU {usage:2}%";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        disk = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };
        tray = {
          "icon-size" = 28;
        };
      };
    };
    style = ''
      * {
        font-size: 20px;
        font-family: FiraCode Nerd Font;
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
        color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
        color: #292b2e;
        background: #1a1a1a;
      }

      #tags,
      #clock.1,
      #clock.2,
      #clock.3,
      #backlight,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
        background: #1a1a1a;
      }

      #tags button {
        padding: 0 2px;
        color: #fdf6e3;
      }
      #tags button.occupied {
        color: #268bd2;
      }
      #tags button.focused {
        color: #e80505;
      }

      #backlight {
        color: #9cd0f7;
      }
      #pulseaudio {
        color: #268bd2;
      }
      #memory {
        color: #2aa198;
      }
      #cpu {
        color: #6c71c4;
      }
      #battery {
        color: #859900;
      }
      #disk {
        color: #b58900;
      }

      #clock,
      #backlight,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
        padding: 0 10px;
      }
    '';
    systemd = {
      enable = false;  # Spawn in river config
    };
  };
}
