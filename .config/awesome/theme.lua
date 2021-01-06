--[[

	Powerarrow Dark Awesome WM theme
	github.com/lcpz

--]]

local gears     = require("gears")
local lain      = require("lain")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local os        = { getenv = os.getenv }
local config    = require("config")
local titlebar  = require("widgets.titlebar")
require("utils")

local theme = {}
local home = os.getenv("HOME")
local here = home.."/.config/awesome/"

local function color(name)
	return "#"..config.colors[name]
end

theme.dir                = here
theme.wallpaper          = home.."/Pictures/Wallpaper"
theme.font               = config.bar_font
theme.fg_normal          = color("fg_gray")
theme.fg_focus           = color("fg_focus")
theme.fg_urgent          = color("white")
theme.bg_normal          = color("bg_dark") --"#1A1A1A"
theme.bg_focus           = color("bg_light") --"#313131"
theme.bg_urgent          = color("red") --"#1A1A1A"
theme.border_normal      = color("base01")--"#3F3F3F"
theme.border_focus       = color("base03")--"#7F7F7F"
theme.border_marked      = color("red")--"#CC9393"
theme.tasklist_bg_focus  = color("bg_dark")--"#1A1A1A"
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

theme.useless_gap  = 0
theme.border_width = 1

theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true

local markup = lain.util.markup
local separators = lain.util.separators

local clock = require("widgets.clock")
local ram   = require("widgets.ram")
local cpu   = require("widgets.cpu")
-- local swap   = require("widgets.swap")
local temp  = require("widgets.temp")
local ld    = require("widgets.load")
local email = require("widgets.email")
local signal= require("widgets.signal")

-- local weather = require("widgets.weather")

theme.music   = require("widgets.music")
theme.volume  = require("widgets.volume")
theme.battery = require("widgets.battery")
-- theme.net     = require("widgets.net")


theme.modkeys     = require("widgets.modkeys")
--[[theme.calendar = lain.widget.calendar({
	cal = "cal -m",
	attach_to = { clock.widget },
	notification_preset = {
		font = config.bar_font,
		fg   = "#"..config.colors.fg_normal,
		bg   = "#"..config.colors.bg_dark,
	}
})]]--

-- Separators
local spr     = wibox.widget.textbox(' ')
local sspr    = wibox.widget.textbox(THIN_SPACE)
local bspr    = wibox.widget.textbox('  ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

theme.titlebar_height = 16
function theme.get_titlebar(c)
	local buttons = awful.util.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)
	awful.titlebar(c, {size = theme.titlebar_height}) : setup {
		{ -- Left
			--awful.titlebar.widget.iconwidget(c),
			--buttons = buttons,

			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			--titlebar.minimizebutton (c),
			titlebar.floatingbutton (c),
			titlebar.maximizedbutton(c),
			--titlebar.stickybutton   (c),
			--titlebar.ontopbutton    (c),
			titlebar.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end

local terminal = "urxvt"
local gui_editor = "neovim"
local menubar = require("menubar")
local freedesktop = require("freedesktop")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end, menubar.utils.lookup_icon("preferences-desktop-keyboard-shortcuts") },
    { "manual", terminal .. " -e man awesome", menubar.utils.lookup_icon("system-help") },
    { "edit config", gui_editor .. " " .. awesome.conffile,  menubar.utils.lookup_icon("accessories-text-editor") },
}
myexitmenu = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
}
theme.mymainmenu = freedesktop.menu.build({
    icon_size = 32,
    before = {
        --{ "Terminal", terminal, menubar.utils.lookup_icon("utilities-terminal") },
        --{ "Browser", browser, menubar.utils.lookup_icon("internet-web-browser") },
        --{ "Files", filemanager, menubar.utils.lookup_icon("system-file-manager") },
        -- other triads can be put here
    },
    after = {
        { "Restart Awesome", awesome.restart, menubar.utils.lookup_icon("system-restart") },
        { "Exit", myexitmenu, menubar.utils.lookup_icon("system-shutdown") },
        -- other triads can be put here
    }
})
mylauncher = awful.widget.launcher({ image = "/usr/share/awesome/icons/awesome32.png", --beautiful.awesome_icon,
                                     menu = theme.mymainmenu })

--mykeyboardlayout = awful.widget.keyboardlayout()

function theme.at_screen_connect(s)
	-- Quake applications
	s.dropdown = config.get_dropdowns()
	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	--s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s,
		function(t)
			--if t.name == "Hidden" then return false end
			if config.special_tags[t.name] then
				return #t:clients() ~= 0
			end
			return true
		end,
		awful.util.taglist_buttons, {
            font = config.top_font,
        })
	--awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create a tasklist widget

	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons,
		{--style
		--shape_border_width = 1,
		--shape_border_color = '#777777',
		--shape  = gears.shape.octogon,
		align = 'center',
		spacing = 10,
        font = config.top_font,
		})

	-- Create the wibox
	--s.mywibox = awful.wibar({ position = "top", screen = s, height = 18, bg = theme.bg_normal, fg = "#"..config.colors.fg_normal })
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 22, bg = theme.bg_normal, fg = "#"..config.colors.fg_normal })


	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
            mylauncher,
			--spr,
			s.mytaglist,
			--s.mypromptbox,
			spr,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
--            mykeyboardlayout,
			spr,
            theme.modkeys.text,
            spr,
			arrl_ld,
			--wibox.container.background(theme.music.icon, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(theme.music.text, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(theme.music.mirrored_arc, theme.bg_focus),
			wibox.container.background(sspr, theme.bg_focus),
			wibox.container.background(theme.volume.widget, theme.bg_focus),
			wibox.container.background(sspr, theme.bg_focus),
			arrl_dl,
			sspr,
			ld.text,
			spr,
			ram.widget,
			spr,
                        -- swap.text,
                        -- spr,
			cpu.widget,
			spr,
			temp.text,
			spr,

			arrl_ld,
            wibox.container.background(email.widget, theme.bg_focus),
            wibox.container.background(email.text, theme.bg_focus),
            --wibox.container.background(spr, theme.bg_focus),
            --wibox.container.background(weather.text, theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            wibox.container.background(signal.widget, theme.bg_focus),
            wibox.container.background(signal.text, theme.bg_focus),
            wibox.container.background(sspr, theme.bg_focus),
			arrl_dl,

			sspr,
			theme.battery.widget,
			spr,
			theme.battery.text,
			spr,

            --theme.net.widget,
			--theme.net.indicator,
			--theme.net.thing,
			--sspr,
			arrl_ld,
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(clock.widget, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			arrl_dl,
			s.mylayoutbox,
		},
	}
end

return theme


