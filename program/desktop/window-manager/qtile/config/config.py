import os
import subprocess
from libqtile import bar, hook, layout, widget
from libqtile.lazy import lazy
from libqtile.config import (Click, Drag, DropDown, EzKey, Match, ScratchPad)
from libqtile.config import Group as Gr
from libqtile.config import Screen as Sc


class Color(object):

    font_active = '#000000'
    font_inactive = '#333333'
    font_urgent = '#e01417'
    bar_background = '#f5f5f5'
    bar_1 = '#b5cdfc'
    bar_2 = '#7eb4f7'
    bar_3 = '#4ba0ea'
    bar_4 = '#2674d3'
    bar_5 = '#3949ab'
    border_focus = '#bbc5ff'
    border_normal = '#292d3e'
    # border_focus = '#ff0000'
    # border_normal = '#000000'


class Font(object):

    base = 'FiraCode'
    bold = 'FiraCode-Bold'


class Screen(object):

    widget_defaults = dict(font=Font.base,
                           fontsize=16,
                           padding=4,
                           foreground=Color.font_active,
                           background=Color.bar_background)
    widgets = [
        widget.GroupBox(
            background=Color.bar_5,
            border=Color.font_active,
            borderwidth=5,
            font=Font.bold,
            fontsize=18,
            active=Color.font_active,
            inactive=Color.font_inactive,
            this_current_screen_border=Color.bar_background,
            highlight_method="block",
            padding_x=10,
            padding_y=5,
            rounded=True,
        ),
        widget.Prompt(),
        widget.WindowName(padding=10),
        widget.Sep(linewidth=0, padding=5),
        widget.Systray(icon_size=22),
        widget.Sep(linewidth=0, padding=5),
        widget.Battery(background=Color.bar_1,
                       charge_char='',
                       discharge_char='',
                       empty_char='',
                       format=('{char} {percent:2.0%} '
                               '{hour:d}:{min:02d}'),
                       unknown_char='',
                       update_interval=5),
        widget.Backlight(backlight_name='intel_backlight',
                         background=Color.bar_2),
        widget.TextBox(text='', background=Color.bar_2),
        widget.Volume(background=Color.bar_2),
        widget.TextBox(text='', background=Color.bar_2),
        widget.Net(background=Color.bar_4,
                   display_format='{down} \u2193\u2191 {up}',
                   use_bits=True,
                   update_interval=1),
        widget.KeyboardLayout(background=Color.bar_5,
                              configured_keyboards=['us', 'de'],
                              update_interval=60),
        widget.CurrentLayoutIcon(background=Color.bar_5),
        widget.CurrentLayout(background=Color.bar_5),
        widget.Pomodoro(background=Color.bar_4,
                        color_active=Color.bar_background,
                        color_inactive=Color.font_urgent),
        widget.Maildir(background=Color.bar_3,
                       maildir_path='~/.local/share/mail/stehessel',
                       sub_folders=[{
                           'path': 'Inbox',
                           'label': 'Inbox'
                       }],
                       update_interval=None),
        widget.DF(partition=os.path.expanduser('~'),
                  warn_space=5,
                  background=Color.bar_3),
        widget.CheckUpdates(distro='Arch_checkupdates',
                            execute='kitty sudo pacman -Syu',
                            update_interval=60,
                            background=Color.bar_2,
                            colour_have_updates=Color.font_active,
                            colour_no_updates=Color.font_active),
        widget.TextBox(text='\uf017', background=Color.bar_1),
        widget.Clock(format='%H:%M', background=Color.bar_1)
    ]

    screens = [
        Sc(top=bar.Bar(widgets=widgets, opacity=1., size=32)),
        Sc(top=bar.Bar(widgets=widgets, opacity=1., size=32))
    ]


class Layout(object):

    floating = layout.Floating(border_focus=Color.border_focus)
    theme = {
        'border_width': 4,
        'margin': 4,
        'border_focus': Color.border_focus,
        'border_normal': Color.border_normal
    }
    layouts = [
        layout.MonadTall(**theme),
        layout.Tile(shift_windows=True, add_after_last=True, **theme),
        layout.Stack(stacks=2, **theme),
        layout.Max(**theme),
        layout.Floating(**theme)
    ]


class Groups(object):

    names = [(u'1 : \uf120', {
        'layout': 'monadtall'
    }), (u'2 : \uf121', {
        'layout': 'monadtall'
    }),
             (u'3 : \uf269', {
                 'layout':
                 'monadtall',
                 'matches':
                 [Match(wm_class=['Navigator', 'firefox'], role='browser')]
             }), (u'4 : \uf87c', {
                 'layout': 'monadtall'
             }), (u'5 : \uf141', {
                 'layout': 'monadtall'
             })]

    @staticmethod
    def init():
        return [Gr(name, **kwargs) for name, kwargs in Groups.names]


class Scratchpad(object):

    keybinds = [
        EzKey('M-<semicolon>',
              lazy.group["scratchpad"].dropdown_toggle("terminal")),
        EzKey('M-<apostrophe>',
              lazy.group["scratchpad"].dropdown_toggle("spotify")),
        EzKey('M-<backslash>',
              lazy.group["scratchpad"].dropdown_toggle("calculator"))
    ]

    @staticmethod
    def init():
        terminal = 'kitty'
        spotify = 'spotify'
        calculator = 'kitty bc -l'
        height = 0.80
        y_position = 0.10
        on_focus_lost_hide = True
        opacity = 1

        return [
            ScratchPad("scratchpad",
                       dropdowns=[
                           DropDown("terminal",
                                    terminal,
                                    opacity=opacity,
                                    y=y_position,
                                    height=height,
                                    on_focus_lost_hide=on_focus_lost_hide,
                                    warp_pointer=False),
                           DropDown("spotify",
                                    spotify,
                                    opacity=opacity,
                                    y=y_position,
                                    height=height,
                                    on_focus_lost_hide=on_focus_lost_hide,
                                    warp_pointer=True),
                           DropDown("calculator",
                                    calculator,
                                    opacity=opacity,
                                    y=y_position,
                                    height=height,
                                    on_focus_lost_hide=on_focus_lost_hide,
                                    warp_pointer=False)
                       ])
        ]


class Function(object):
    """Custom lazy functions"""
    @staticmethod
    def window_to_group(direction):
        def __inner(qtile, direction):
            if qtile.current_window and qtile.current_group:
                new_index = (
                    (qtile.groups.index(qtile.current_group) + direction) %
                    len(qtile.groups))
                qtile.move_to_group(qtile.groups[new_index].name)

        return lazy.function(__inner, direction)

    @staticmethod
    def window_to_screen(direction):
        def __inner(qtile, direction):
            other_screen_index = (
                (qtile.screens.index(qtile.current_screen) + direction) %
                len(qtile.screens))
            other_group = qtile.screens[other_screen_index].group.name
            qtile.current_window.togroup(other_group)

        return lazy.function(__inner, direction)

    @staticmethod
    def focus_last_window():
        @lazy.function
        def __inner(qtile):
            if Hook.screen_hist[0] is not qtile.current_screen:
                qtile.focus_screen(Hook.screen_hist[0].index)
            if Hook.group_hist[0] is qtile.current_group:
                qtile.current_group.cmd_focus_back()
            else:
                qtile.current_screen.cmd_toggle_group()

        return __inner

    @staticmethod
    def sink_all_windows():
        @lazy.function
        def __inner(qtile):
            for w in qtile.current_group.windows:
                w.floating = False

        return __inner

    @staticmethod
    def rotate_clockwise():
        @lazy.function
        def __inner(qtile):
            current_window = qtile.current_window
            last_window = qtile.current_layout.focus_last()
            qtile.current_group.focus(last_window)
            for _ in range(len(qtile.current_group.windows) - 1):
                qtile.current_layout.cmd_shuffle_up()
            qtile.current_group.focus(current_window)

        return __inner

    @staticmethod
    def rotate_counter_clockwise():
        @lazy.function
        def __inner(qtile):
            current_window = qtile.current_window
            first_window = qtile.current_layout.focus_first()
            qtile.current_group.focus(first_window)
            for _ in range(len(qtile.current_group.windows) - 1):
                qtile.current_layout.cmd_shuffle_down()
            qtile.current_group.focus(current_window)

        return __inner

    @staticmethod
    def find_window_by_prompt():
        @lazy.function
        def __inner(qtile):
            query = 'Select window'
            width = 50
            entries = []
            groups, windows = {}, {}
            for g in qtile.groups:
                groups[g.name] = g
                for w in g.windows:
                    entries.append(f'{g.name} , {w.name}')
                    windows[w.name] = w
            cmd = (f"echo '{'|'.join(sorted(entries))}' | rofi -sep '|' "
                   f"-dmenu -i -p '{query}' -location 3 -xoffset -14 "
                   f"-yoffset 45 -width -{width} -hide-scrollbar "
                   f"-line-padding 4 -padding 20 -lines {len(entries)}")
            selection = (subprocess.check_output(
                cmd, shell=True).decode('utf-8').rstrip('\n').split(' , '))
            group, window = groups[selection[0]], windows[selection[1]]
            if group is not qtile.current_group:
                group.cmd_toscreen()
            if window is not qtile.current_window:
                group.focus(window)

        return __inner


class Hook(object):

    screen_hist = [None, None]
    group_hist = [None, None]
    window_hist = [None, None]

    @staticmethod
    @hook.subscribe.screen_change
    def init_screens(qtile, event):
        subprocess.run(["autorandr", "--change"])
        qtile.cmd_restart()

    @staticmethod
    @hook.subscribe.client_new
    def floating(window):
        floating_types = ['notification', 'toolbar', 'splash', 'dialog']
        transient = window.window.get_wm_transient_for()
        if window.window.get_wm_type() in floating_types or transient:
            window.floating = True

    @staticmethod
    def update_history(qtile):
        if qtile.current_window is not Hook.window_hist[1]:
            Hook.screen_hist = [Hook.screen_hist[1], qtile.current_screen]
            Hook.group_hist = [Hook.group_hist[1], qtile.current_group]
            Hook.window_hist = [Hook.window_hist[1], qtile.current_window]


class Keys(object):

    mod = "mod4"

    @staticmethod
    def init():
        keybinds = [
            # Kill window
            EzKey('M-q', lazy.window.kill()),
            # Restart Qtile
            EzKey('M-S-r', lazy.restart()),
            # Shutdown Qtile
            EzKey('M-S-q', lazy.shutdown()),
            # Toggle bar
            EzKey('M-b', lazy.hide_show_bar()),

            # Toggle floating
            EzKey('M-d', lazy.window.toggle_floating()),
            # Sink all windows
            EzKey('M-S-d', Function.sink_all_windows()),
            # Toggle fullscreen
            EzKey('M-f', lazy.window.toggle_fullscreen()),
            # Switch to the next layouts
            EzKey('M-i', lazy.next_layout()),
            # Switch to the next layouts
            EzKey('M-o', lazy.prev_layout()),

            # Switch to previous screen
            EzKey('M-<Left>', lazy.screen.previous()),
            EzKey('M-y', lazy.screen.previous()),
            # Switch to next screen
            EzKey('M-<Right>', lazy.screen.next()),
            EzKey('M-u', lazy.screen.next()),
            # Move window to previous screen
            EzKey('M-S-<Left>', Function.window_to_screen(direction=-1)),
            EzKey('M-S-y', Function.window_to_screen(direction=-1)),
            # Move window to next screen
            EzKey('M-S-<Right>', Function.window_to_screen(direction=1)),
            EzKey('M-S-u', Function.window_to_screen(direction=1)),

            # Switch to previous group
            EzKey('M-<bracketleft>', lazy.screen.prev_group(skip_empty=True)),
            # Switch to next group
            EzKey('M-<bracketright>', lazy.screen.next_group(skip_empty=True)),
            # Switch focus to the last focused window
            EzKey('M-n', Function.focus_last_window()),
            # Switch to the next urgent window
            EzKey('M-p', lazy.next_urgent()),
            # Shift window to previous group and follow
            EzKey('M-S-<bracketleft>', Function.window_to_group(direction=-1),
                  lazy.screen.prev_group()),
            # Shift window to next group and follow
            EzKey('M-S-<bracketright>', Function.window_to_group(direction=1),
                  lazy.screen.next_group()),

            # Switch focus to the next window in group
            EzKey('M-j', lazy.group.next_window()),
            # Switch focus to the previous window in group
            EzKey('M-k', lazy.group.prev_window()),
            # Open prompt to find window and focus it
            EzKey('M-<slash>', Function.find_window_by_prompt()),

            # Shrink size of current window (XmonadTall)
            # Decrease number in master pane (Tile)
            # Move window to the next stack pane (Stack)
            EzKey('M-h', lazy.layout.shrink(), lazy.layout.decrease_nmaster(),
                  lazy.layout.client_to_previous()),
            # Grow size of current window (XmonadTall)
            # Increase number in master pane (Tile)
            # Move window to the next stack pane (Stack)
            EzKey('M-l', lazy.layout.grow(), lazy.layout.increase_nmaster(),
                  lazy.layout.client_to_next()),
            # Move window down in current stack
            EzKey('M-S-j', lazy.layout.shuffle_down()),
            # Move window up in current stack
            EzKey('M-S-k', lazy.layout.shuffle_up()),
            # Swap window to the left (XmonadTall)
            # Move window to the previous stack pane (Stack)
            EzKey("M-S-h", lazy.layout.swap_left(),
                  lazy.layout.client_to_previous()),
            # Swap window to the right (XmonadTall)
            # Move window to the next stack pane (Stack)
            EzKey('M-S-l', lazy.layout.swap_right(),
                  lazy.layout.client_to_next()),
            # Rotate windows in current group forward
            EzKey('M-<comma>', Function.rotate_clockwise()),
            # Rotate windows in current group backsward
            EzKey('M-<period>', Function.rotate_counter_clockwise()),

            # Toggle between minimum and maximum window sizes
            EzKey('M-m', lazy.layout.maximize()),
            # Restore all windows to default size ratios
            EzKey('M-<equal>', lazy.layout.reset()),
            # Restore secondary windows to default size ratios
            EzKey('M-S-<equal>', lazy.layout.normalize()),

            # Switch window focus to other pane(s) of stack
            EzKey('M-<Tab>', lazy.layout.next()),
            # Swap panes of split stack (Stack)
            # Switch which side main pane occupies (XmonadTall)
            EzKey('M-S-<Tab>', lazy.layout.rotate(), lazy.layout.flip()),
            # Toggle between split and unsplit sides of stack
            EzKey('M-<grave>', lazy.layout.toggle_split())
        ]

        for i, (name, kwargs) in enumerate(Groups.names, 1):
            # Switch to another group
            keybinds.append(EzKey(f'M-{i}', lazy.group[name].toscreen()))
            # Send current window to another group
            keybinds.append(EzKey(f'M-S-{i}', lazy.window.togroup(name)))

        return keybinds


class Mouse(object):
    mouse = [
        # Move floating windows
        Drag([Keys.mod],
             "Button1",
             lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        # Resize floating windows
        Drag([Keys.mod],
             "Button3",
             lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        # Bring floating window to front
        Click([Keys.mod, "shift"], "Button1", lazy.window.bring_to_front())
    ]


def main(qtile):
    @hook.subscribe.focus_change
    def update_history_hook():
        Hook.update_history(qtile)


if __name__ in ["config", "__main__"]:
    keys = Keys.init() + Scratchpad.keybinds
    mouse = Mouse.mouse
    group_names = Groups.names
    groups = Groups.init() + Scratchpad.init()
    floating_layout = Layout.floating
    layout_theme = Layout.theme
    layouts = Layout.layouts
    screens = Screen.screens
    widget_defaults = Screen.widget_defaults

    # bring_front_click = True
    cursor_warp = True
    follow_mouse_focus = False
    wmname = "qtile"
    # wmname = "LG3D"
