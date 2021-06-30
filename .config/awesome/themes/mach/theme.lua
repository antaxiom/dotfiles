-------------------------------
--  "Too Dark" awesome theme --
--     By Antaxiom (Alex)    --
--    Based on the Zenburn   --
-------------------------------

local themes_path = "/home/alex/.config/awesome/themes/"
local dpi = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")


-- {{{ Main
local theme = {}
-- }}}

-- {{{ Styles
theme.font      = "JetBrainsMonoMedium Nerd Font 12.5"

-- {{{ Colors
theme.fg_normal  = "#DDDDDD"
theme.fg_focus   = "#e06ccd"
theme.fg_urgent  = "#61afef"
theme.bg_normal  = "#171717"
theme.bg_focus   = "#1C1C1C"
theme.bg_urgent  = "#171717"
-- }}}

-- {{{ borders
theme.useless_gap   = dpi(6)
theme.border_width  = dpi(4)
theme.border_normal = "#202020"
theme.border_focus  = "#61afef"
theme.border_marked = "#202020"
theme.border_radius = dpi(0)
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#61afef"
theme.titlebar_bg_normal = "#202020"
theme.titlebar_size = dpi(0)
-- }}}
--
-- {{{
-- Tasklist
    theme.tasklist_plain_task_name = true
    theme.tasklist_disable_task_name = false
    theme.tasklist_disable_icon = true
    theme.tasklist_spacing = dpi(5)
    theme.tasklist_align = "center"
-- }}}

-- {{{
-- Systray
theme.systray_icon_spacing = dpi(1)
theme.systray_icon_size = dpi(17)
-- }}}

--
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}
theme.taglist_fg_empty = "#444444"
-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- Wibar

theme.wibar_height = dpi(46)
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = "#111111"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}


-- {{{ Icons
-- {{{ Misc
theme.awesome_icon           = themes_path .. "mach/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "mach/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "mach/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "mach/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "mach/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "mach/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "mach/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "mach/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "mach/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "mach/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "mach/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "mach/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "mach/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "mach/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "mach/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "mach/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "mach/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "mach/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "mach/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

--[[ Bling theme variables template
This file has all theme variables of the bling module.
Every variable has a small comment on what it does.
You might just want to copy that whole part into your theme.lua and start adjusting from there.
--]]


-- window swallowing
theme.dont_swallow_classname_list    = {"firefox", "Gimp", "brave-browser"}
-- list of class names that should not be swallowed
theme.dont_swallow_filter_activated  = true                     -- whether the filter above should be active

-- flash focus
theme.flash_focus_start_opacity = 0.6       -- the starting opacity
theme.flash_focus_step = 0.01               -- the step of animation

-- tabbed
theme.tabbed_spawn_in_tab = false           -- whether a new client should spawn into the focused tabbing container

-- tabbar general
theme.tabbar_ontop  = true
theme.tabbar_radius = dpi(4)                     -- border radius of the tabbar
theme.tabbar_style = "default"              -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = "JetBrainsMonoMedium 13"               -- font of the tabbar
theme.tabbar_size = dpi(42)                      -- size of the tabbar
theme.tabbar_position = "boxes"               -- position of the tabbar
theme.tabbar_bg_normal = "#151515"          -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = "#ffffff"          -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus  = "#1b1b1b"          -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus  = "#61afef"          -- foreground color of unfocused clients on the tabbar

-- mstab
theme.mstab_bar_ontop = false               -- whether you want to allow the bar to be ontop of clients
theme.mstab_dont_resize_flaves = false      -- whether the tabbed stack windows should be smaller than the
                                            -- currently focused stack window (set it to true if you use
                                            -- transparent terminals. False if you use shadows on solid ones
theme.mstab_bar_padding = dpi(4)         -- how much padding there should be between clients and your tabbar
                                            -- by default it will adjust based on your useless gaps.
                                            -- If you want a custom value. Set it to the number of pixels (int)

-- the following variables are still for mstab
-- you only need to set them if you want your mstab layout tabbar to have a different
-- look then your tabbed module tabbar. By default they will look the same.
theme.mstab_border_radius = dpi(0)               -- border radius of the tabbar
theme.mstab_tabbar_style = "default"        -- style of the tabbar ("default", "boxes" or "modern")
theme.mstab_font = "JetBrainsMonoMedium 12"                -- font of the tabbar
theme.mstab_bar_height = dpi(48)                 -- height of the tabbar
theme.mstab_tabbar_position = "top"         -- position of the tabbar (mstab currently does not support left,right)
theme.mstab_bg_normal   = "#1b1b1b"         -- background color of unfocused clients on the tabbar

-- the following variables are currently only for the "modern" tabbar style
theme.tabbar_color_close = "#1b1b1b"        -- chnges the color of the close button
theme.tabbar_color_min   = "#1b1b1b"        -- chnges the color of the minimize button
theme.tabbar_color_float = "#1b1b1b"        -- chnges the color of the float button


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

return theme
