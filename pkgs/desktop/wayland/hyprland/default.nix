{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Display
      monitor = ,preferred,auto,1

      # Start up
      exec-once  = wl-paste --watch cliphist store
      exec-once  = swaync
      windowrule = workspace 1 silent, brave
      windowrule = workspace 2 silent, foot
      exec-once  = brave
      exec-once  = foot
      exec-once  = cleanup_after_start.sh

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options = caps:escape
          kb_rules =

          repeat_rate = 70
          repeat_delay = 200

          follow_mouse = 1

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 3
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = master
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          blur = yes
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = on

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic mouse V1 {
          sensitivity = -0.5
      }

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      bind = $mainMod,      Q,     exec,           foot
      bind = $mainMod,      C,     killactive,
      bind = $mainMod CTRL, C,     exit,
      bind = $mainMod,      space, exec,           wofi --show drun
      bind = $mainMod,      F,     fullscreen,
      bind = $mainMod CTRL, F,     togglefloating,
      bind = $mainMod,      V,     exec,           cliphist list | wofi --dmenu | cliphist decode | wl-copy
      bind = $mainMod CTRL, V,     exec,           rm $XDG_CACHE_HOME/cliphist/db
      bind = $mainMod,      P,     pin,
      bind = $mainMod,      L,     exec,           ${pkgs.swaylock}/bin/swaylock

      # Window binds
      bind = $mainMod,       J, cyclenext,          next
      bind = $mainMod SHIFT, J, swapnext,           next
      bind = $mainMod,       K, cyclenext,          prev
      bind = $mainMod SHIFT, K, swapnext,           prev
      bind = $mainMod,       N, focusCurrentOrLast,

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left,  movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up,    movefocus, u
      bind = $mainMod, down,  movefocus, d

      # Master layout
      bind = $mainMod,       M,      layoutmsg, focusmaster
      bind = $mainMod SHIFT, M,      layoutmsg, swapwithmaster
      bind = $mainMod,       return, layoutmsg, addmaster
      bind = $mainMod SHIFT, return, layoutmsg, removemaster
      bind = $mainMod,       I,      layoutmsg, orientationnext
      bind = $mainMod,       O,      layoutmsg, orientationprev

      # Switch workspaces
      bind = $mainMod, bracketleft,  workspace, -1
      bind = $mainMod, bracketright, workspace, +1
      bind = $mainMod, 1,            workspace, 1
      bind = $mainMod, 2,            workspace, 2
      bind = $mainMod, 3,            workspace, 3
      bind = $mainMod, 4,            workspace, 4
      bind = $mainMod, 5,            workspace, 5
      bind = $mainMod, 6,            workspace, 6
      bind = $mainMod, 7,            workspace, 7
      bind = $mainMod, 8,            workspace, 8
      bind = $mainMod, 9,            workspace, 9
      bind = $mainMod, 0,            workspace, 10
      bind = $mainMod, P,            togglespecialworkspace,

      # Move active window to a workspace
      bind = $mainMod SHIFT, bracketleft,  movetoworkspace, -1
      bind = $mainMod SHIFT, bracketright, movetoworkspace, +1
      bind = $mainMod SHIFT, 1,            movetoworkspace, 1
      bind = $mainMod SHIFT, 2,            movetoworkspace, 2
      bind = $mainMod SHIFT, 3,            movetoworkspace, 3
      bind = $mainMod SHIFT, 4,            movetoworkspace, 4
      bind = $mainMod SHIFT, 5,            movetoworkspace, 5
      bind = $mainMod SHIFT, 6,            movetoworkspace, 6
      bind = $mainMod SHIFT, 7,            movetoworkspace, 7
      bind = $mainMod SHIFT, 8,            movetoworkspace, 8
      bind = $mainMod SHIFT, 9,            movetoworkspace, 9
      bind = $mainMod SHIFT, 0,            movetoworkspace, 10
      bind = $mainMod SHIFT, P,            movetoworkspace, special

      # Monitor binds
      # bind = $mainMod      , comma,  monitor, -1
      # bind = $mainMod SHIFT, comma,  movecurrentworkspacetomonitor, -1
      # bind = $mainMod      , period, monitor, +1
      # bind = $mainMod SHIFT, period, movecurrentworkspacetomonitor, +1

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up,   workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Media keys
      binde = , xf86audioraisevolume,  exec, pamixer -i 5
      binde = , xf86audiolowervolume,  exec, pamixer -d 5
      bind  = , xf86audiomute,         exec, pamixer --toggle-mute
      bind  = , xf86audiomedia,        exec, playerctl play-pause
      bind  = , xf86audioplay,         exec, playerctl play-pause
      bind  = , xf86audionext,         exec, playerctl next
      bind  = , xf86audioprev,         exec, playerctl previous
      binde = , xf86monbrightnessup,   exec, brightnessctl --device intel_backlight set 5%+
      binde = , xf86monbrightnessdown, exec, brightnessctl --device intel_backlight set 5%-
    '';
  };

  home.file.".local/bin/cleanup_after_start.sh".source = config/cleanup_after_start.sh;
}
