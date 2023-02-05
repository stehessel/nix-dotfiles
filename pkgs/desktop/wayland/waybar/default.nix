_: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 20;

        modules-left = [
          "wlr/workspaces"
        ];
        modules-right = [
          "backlight"
          "pulseaudio"
          "memory"
          "cpu"
          "battery"
          "disk"
          "clock#1"
          "clock#2"
          "clock#3"
          "tray"
        ];

        # `wlr/workspaces` require compositor to implement ext_workspace_unstable_v1 wayland protocol (which is not merged yet).
        "wlr/workspaces" = {
          "format" = "{icon}";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };

        "clock#1" = {
          format = "{:%G-%m-%d}";
        };
        "clock#2" = {
          format = "{:%a}";
        };
        "clock#3" = {
          format = "{:%H:%M}";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent:2}%";
          format-icons = ["" ""];
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

      #workspaces,
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

      #workspaces button {
        padding: 0 2px;
        color: #fdf6e3;
      }
      #workspaces button.active {
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
      enable = true;
    };
  };
}
