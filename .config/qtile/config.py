# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

import subprocess
import os
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


@hook.subscribe.startup
def autostart():
    subprocess.call(["/home/alex/.config/qtile/autostart.sh"])


mod = "mod4"
terminal = guess_terminal()  # I use alacritty but just in case to be nice to others

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),
    Key([mod, "shift"], "l",
        lazy.layout.right(),
        desc='Move focus right in the stack pane'
        ),
    Key([mod, "shift"], "h",
        lazy.layout.left(),
        desc='Move focus left in the stack pane'
        ),

    # Change layout

    Key([mod], "y",
        lazy.prev_layout(),
        desc='Goes to the next layout'
        ),
    Key([mod], "t",
        lazy.next_layout(),
        desc='Goes to the last layout'
        ),

    # Grow or shrink windows up and down
    Key([mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='normalize window size ratios'
        ),

    # Stack controls
    Key([mod, "shift"], "Return",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
        ),

    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
        ),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    Key([mod], "f", lazy.window.toggle_fullscreen(),
        desc="Toggles fullscreen on the current window"),

    Key([mod, "shift"], "space",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),

    # Launchers
    Key([mod], "r", lazy.spawn("dmenu_run -p run")),
    Key([mod], "d", lazy.spawn(
        "j4-dmenu-desktop --no-generic  --dmenu='dmenu -p start'")),


    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
]


colors = [
    ["#151515", "#151515"],  # panel background
    ["#be4dcc", "#be4dcc"],  # background for current screen tab
    ["#ffffff", "#ffffff"],  # font color for group names
    ["#444444", "#444444"],  # window border
    ["#5bc5d1", "#5bc6d1"],  # window border selected
    ["#151515", "#1D1D1D"],  # Group gradient
]

group_names = '一 二 三 四 五 六 七 八 九'.split()
groups = [Group(name, layout="[]=") for name in group_names]
for i, name in enumerate(group_names):
    indx = str(i + 1)
    keys += [
        Key([mod], indx, lazy.group[name].toscreen()),
        Key([mod, 'shift'], indx, lazy.window.togroup(name))]

layout_theme = {
    "border_width": 4,
    "margin": 12, # Gaps
    "border_focus": "5bc6d1",
    "border_normal": "444444"
}

layouts = [
    layout.MonadTall(name="[]=", **layout_theme),
    layout.Max(name="[-]", **layout_theme),
    # layout.Matrix(name="*-*", **layout_theme),
    # layout.Floating(name="<>", **layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
]


widget_defaults = dict(
    font='JetBrains Mono Medium',
    fontsize=24,
    padding=8,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    text='',
                    background=colors[1],
                    foreground=colors[2],
                    font='JetBrainsMonoExtraBold Nerd Font Mono',
                    fontsize=36,
                    padding=14
                ),
                widget.GroupBox(
                    highlight_method="line",
                    background=colors[0],
                    borderwidth=5,
                    padding_x=8,
                    margin_x=0,
                    rounded=False,
                    highlight_color=colors[5],
                    this_current_screen_border=colors[1],
                    this_screen_border=colors[1],
                    other_current_screen_border=colors[1],
                    other_screen_border=colors[1]
                ),
                widget.CurrentLayout(
                    background=colors[0],
                    foreground=colors[1]
                ),
                widget.Prompt(
                    background=colors[0]
                ),
                widget.WindowName(
                    background=colors[0]
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(
                    background=colors[0],
                    icon_size=28
                ),
                widget.Battery(
                    background=colors[0],
                    low_foreground='fe4444',
                    discharge_char='[-]',
                    charge_char='[+]',
                    full_char='[++]',
                    format='{char} {percent:2.0%} ({hour:d}h:{min:02d}m)',
                    update_interval=2,
                    show_short_text=False
                ),
                widget.Clock(
                    background=colors[0],
                    format='%b %d (%a) %I:%M%p'
                ),
            ],
            46,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        Match(wm_type='utility'),
        Match(wm_type='notification'),
        Match(wm_type='toolbar'),
        Match(wm_type='splash'),
        Match(wm_type='dialog'),
        Match(wm_class='file_progress'),
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
