-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
-- Theme handling library
local beautiful = require("beautiful")
local menubar = require("menubar")
local stolen = require("./stolen")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Variables
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/mach/theme.lua")

local bling = require("bling")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    -- Bling layouts
    bling.layout.mstab,
    bling.layout.centered,
    awful.layout.suit.floating,
    -- bling.layout.vertical,
    -- bling.layout.horizontal,
}

awful.layout.suit.tile.name = "[]="
-- awful.layout.suit.spiral.dwindle.name = "[\\]"
awful.layout.suit.max.name = "[0]"
awful.layout.suit.corner.nw.name = "=||"
bling.layout.mstab.name = "[]^"
bling.layout.centered.name = "|M|"
awful.layout.suit.floating.name = "><>"

-- Mess to make it so monacle / max doesn't have gaps
tag.connect_signal("property::layout", function(t)
    if t.layout.name == "[0]" then
        t.gap = dpi(0)
    else
        t.gap = dpi(4)
    end
end)

-- Floating Windows Always on Top
-- Doesn't full work but it's ok
-- client.connect_signal("property::floating", function(c)
--     if c.floating == true then
--         c.ontop = true
--     end
-- end)

-- Other Bling Things

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar


local mytextclock = wibox.widget.textclock()
local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach( mytextclock, "tr" )

mytextclock = {
wibox.widget.textclock("%b %d (%a) %I:%M%p"),
widget = wibox.container.background,
fg = "#111111"
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"一", "二", "三", "四", "五", "六", "七", "八", "九"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end)))
   -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {shape = gears.shape.rectangle},
        layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.horizontal
                },
                left = 12,
                right = 12,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        },
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {shape = gears.shape.rectangle},
        layout = {spacing = 10, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
            {
                {
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.flex.horizontal
                },
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        },
    widget = wibox.container.constraint,
    width = dpi(490)
    }
    }

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    top = dpi(10),
    left = dpi(6),
    right = dpi(6),
    widget = wibox.container.margin
}

-- Setup functions
function wrap_bg(widget, bg_color)
  return wibox.widget {
    widget,
    bg = bg_color,
    shape = gears.shape.rectangle,
    widget = wibox.container.background
  }
end


function wrap_margin(widget, bg_color)
  return wibox.widget {
    widget,
    left = dpi(7),
    right = dpi(7),
    widget = wibox.container.margin,
    bg = "#111111"
  }
end

function full_wrap_margin(widget)
  return wibox.widget {
    widget,
    left = dpi(3),
    right = dpi(3),
    top = dpi(6),
    bottom = dpi(6),
    widget = wibox.container.margin,
  }
end
--
-- Playctl widget
local music_widget =
{
    {
    awful.widget.watch("playerctl metadata --format ' {{ title }}'",
    1, function(widget, stdout)
    widget:set_markup(stdout:gsub("\n", ""))
    widget.align = "center"
end),
widget = wibox.container.background,
fg = "#111111",
},
widget = wibox.container.constraint,
width = dpi(425)

}

      -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            full_wrap_margin(wrap_bg(s.mytaglist,"#171717")),
            wrap_margin(s.mylayoutbox),
        },
        full_wrap_margin(wrap_bg(s.mytasklist, "#111111")), -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.only_on_screen(
            full_wrap_margin(wrap_bg(mysystray_container, "#171717"), 1)),
            awful.widget.only_on_screen(full_wrap_margin(wrap_bg(wrap_margin(music_widget), "#ff4444")), 1),
            full_wrap_margin(wrap_bg(wrap_margin(mytextclock), "#61afef")),
        },
    }
end)
-- }}}

-- Bindings

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))

-- Import the main bindings
require("mappings")

-- }}}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
                     border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap + awful.placement.centered + awful.placement.no_offscreen,
                     size_hints_honor = false,
                     honor_workarea = false,
                     maximized = false,
                     maximized_horizontal = false,
                     maximized_vertical = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

 -- Add titlebars to normal clients and dialogs (FOR DOUBLE BORDERS)
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    },
    {
        rule_any = {class = {"Steam"}},
        properties = {ontop = false}
    }, -- Set Firefox to always map on the tag named "2" on screen 1.
    --   { rule = { class = "Firefox" },
    --     properties = {  tag = 2 } },
    {
        rule_any = {
            instance = {"scratch"},
            class = {"scratch"},
            icon_name = {"scratchpad_urxvt"}
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = screen_width * 0.5,
            height = screen_height * 0.5
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true
            })
            gears.timer.delayed_call(function() c.urgent = false end)
        end
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    end
end)


-- {{ Helper to create mult tb buttons
local function create_title_button(c, color_focus, color_unfocus)
    local tb_color = wibox.widget {
        bg = color_focus,
        widget = wibox.container.background
    }

    local tb = wibox.widget {
        tb_color,
        width = 25,
        height = 20,
        strategy = "min",
        layout = wibox.layout.constraint
    }

    local function update()
        if client.focus == c then
            tb_color.bg = color_focus
        else
            tb_color.bg = color_unfocus
        end
    end
    update()
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    client.connect_signal("property::floating", function(c)
        local b = false;
        if c.first_tag ~= nil then
            b = c.first_tag.layout.name == "floating"
        end
        if c.floating or b then
            tb.visible = true
        else
            tb.visible = false
        end
    end)

    client.connect_signal("manage", function(c)
        if c.floating or c.first_tag.layout.name == "floating" then
            tb.visible = true
        else
            tb.visible = false
        end
    end)

    tag.connect_signal("property::layout", function(t)
        local clients = t:clients()
        for k, c in pairs(clients) do
            if c.floating or c.first_tag.layout.name == "floating" then
                tb.visible = true
            else
                tb.visible = false
            end
        end
    end)

    return tb
end
-- }}

-- Double Borders
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))
    local borderbuttons = gears.table.join(
                              awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end), awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end))

    local close = create_title_button(c, beautiful.xcolor1, beautiful.xcolor0)
    close:connect_signal("button::press", function() c:kill() end)

    local floating =
        create_title_button(c, beautiful.xcolor5, beautiful.xcolor0)
    floating:connect_signal("button::press",
                            function() c.floating = not c.floating end)

    awful.titlebar(c, {position = "right", size = beautiful.titlebar_size}):setup{
        {close, layout = wibox.layout.flex.vertical},
        layout = wibox.layout.align.vertical
    }
    awful.titlebar(c, {position = "left", size = beautiful.titlebar_size}):setup{
        {floating, layout = wibox.layout.flex.vertical},
        layout = wibox.layout.align.vertical

    }
    awful.titlebar(c, {position = "bottom", size = beautiful.titlebar_size}):setup{
        buttons = borderbuttons,
        layout = wibox.layout.fixed.horizontal
    }
    awful.titlebar(c, {position = "top", size = beautiful.titlebar_size}):setup{
        buttons = borderbuttons,
        layout = wibox.layout.fixed.horizontal
    }
    awful.titlebar(c, {position = "top", size = beautiful.titlebar_size}):setup{
        { -- Left
            --            awful.titlebar.widget.iconwidget(c),
            floating,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            close,
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--- Autostart Script
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
