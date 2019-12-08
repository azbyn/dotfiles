--[[

	Awesome WM configuration template
	github.com/lcpz

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget


local config = require("config")
local keybindings = require("keybindings")

local theme = require("theme")

require("awful.autofocus")
require("utils")


if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		if in_error then return end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end

awful.util.terminal = config.term
awful.util.tagnames = config.tags
awful.layout.layouts = config.layouts

beautiful.init(theme)

awful.util.taglist_buttons = awful.util.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ mod }, 1,
		function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
	awful.button({ }, 3, awful.tag.viewtoggle)
)
awful.util.tasklist_buttons = awful.util.table.join(
	awful.button({ }, 1,
		function(c)
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			
			client.focus = c
			c:raise()
		end)
	--[[
	awful.button({ }, 3,
		function()
			local instance = nil

			return function()
				if instance and instance.wibox.visible then
					instance:hide()
					instance = nil
				else
					instance = awful.menu.clients({ theme = { width = 250 } })
				end
			end
		end)
	]]
)

-- }}}

--[[
local myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end },
	{ "manual", M.term.." -e man awesome" },
	{ "edit config", string.format("%s %s", cmd_geditor, awesome.conffile) },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
	icon_size = beautiful.menu_height or 16,
	before = {
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
	},
	after = {
		{ "Open terminal", M.term },
	}
})
]]--

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry",
	function(s)
	-- Wallpaper
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper
			-- If wallpaper is a function, call it with the screen
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end
			gears.wallpaper.maximized(wallpaper, s, true)
		end
	end)
-- Create a wibox for each screen and add it
--awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
awful.screen.connect_for_each_screen(function(s) theme.at_screen_connect(s) end)
-- }}}} }

-- {{{ Mouse bindings
--[[
root.buttons(awful.util.table.join(
	--awful.button({ }, 3, function() awful.util.mymainmenu:toggle() end)
	--awful.button({ }, 4, awful.tag.viewnext),
	--awful.button({ }, 5, awful.tag.viewprev)
))
]]--
--awful.button.ignore_modifiers = {}
clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end)--,
	--awful.button({ mod }, 1, awful.mouse.client.move),
	--awful.button({ mod }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(keybindings.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = config.program_rules
table.insert(awful.rules.rules, {
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keybindings.clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen,
			size_hints_honor = false
		}
	})

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup and
		c and c.name and
		not string.find(c.name, "QuakeDD.*") then
		awful.client.setslave(c)
	end

	if awesome.startup and
		not c.size_hints.user_position and
		not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", theme.get_titlebar)
-- Enable sloppy focus, so that focus follows mouse.
--[[client.connect_signal("mouse::enter", function(c)
	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
		client.focus = c
	end
end)]]--

-- No border for maximized clients
client.connect_signal("focus",
	function(c)
		if c.maximized then -- no borders if only 1 client visible
			c.border_width = 0
		elseif #awful.screen.focused().clients > 1 then
			c.border_width = beautiful.border_width
			c.border_color = beautiful.border_focus
		end
	end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


-- start_file should be created in .xinitrc
local start_file = "/tmp/awesome_just_started"
local just_started = file_exists(start_file)


for _, x in ipairs(config.autorun) do
	local when = x[1]
	local cmd = x[2]
	if when == "once" or when == "once_sh" then
		run_once(cmd)
	elseif when == "start" then
		if just_started then
			awful.spawn(cmd)
		end
	elseif when == "start_sh" then
		if just_started then
			awful.spawn.with_shell(cmd)
		end
	elseif when == "start_fn" then
		if just_started then
			cmd()
		end
	elseif when == "always" then
		awful.spawn(cmd)
	elseif when == "always_sh" then
		awful.spawn.with_shell(cmd)
	elseif when == "always_fn" then
		cmd()
	else
		error(sprintf("invalid when: '%s'", when))
	end
end

awful.spawn.with_shell(sprintf("sleep 1; rm -f %s", start_file))


