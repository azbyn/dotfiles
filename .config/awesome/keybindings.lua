local awful = require("awful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

local lain = require("lain")
local naughty = require("naughty")
local gears = require("gears")
local theme = require("theme")

local beautiful = require("beautiful")
local theme = require("theme")
--theme = beautiful.get()
--require("awful.hotkeys_popup.keys")

require("utils")
local M = {}

local mod   = "Mod4"
local alt   = "Mod1"
local ctrl  = "Control"
local shift = "Shift"

local term = {"Program", "Terminal (URXVT)",
	exec("urxvt")}

local browser1 = {"Program", "Browser - qutebrowser",
	exec_tag_special("W")}
local browser2 = {"Program", "Browser - Iceweasel",
	exec("iceweasel")}
local launcher1 = {"Program", "Program Launcher",
	exec("rofi -modi drun -show drun")}
local launcher2  = {"Program", "Command Launcher",
	exec("rofi -modi run -show run")}--awful.screen.focused().mypromptbox:run()


local music = {
	next = {"Music", "Next Song",
		theme.music.call("mpc next")},
	prev = {"Music", "Previous Song",
		theme.music.call("mpc prev")},
	toggle = {"Music", "Play/Pause Music",
		theme.music.call("mpc toggle")},
	pause = {"Music", "Pause Music",
		theme.music.call("mpc pause")},
	fwd = {"Music", "Seek Forward",
		theme.music.call("mpc seek +5")},
	bfwd = {"Music", "Seek Forward Big",
		theme.music.call("mpc seek +30")},
	bwd = {"Music", "Seek Backward",
		theme.music.call("mpc seek -5")},
	bbwd = {"Music", "Seek Backward Big",
		theme.music.call("mpc seek -30")},
	beg = {"Music", "Seek Begining",
		theme.music.call("mpc seek 0%")},
}
local vol = {
	up = {"Volume", "Volume Up",
		theme.volume.call("amixer sset Master 5%+")},
	sup = {"Volume", "Volume Small Up",
		theme.volume.call("amixer sset Master 1%+")},
	down = {"Volume", "Volume Down",
		theme.volume.call("amixer sset Master 5%-")},
	sdown = {"Volume", "Volume Small Down",
		theme.volume.call("amixer sset Master 1%-")},
	mute = {"Volume", "Volume Mute",
		theme.volume.call("amixer sset Master toggle")},
}
local brightness = {
	up = {"Brightness", "Brightness Up",
		exec("light -A 10")},
	down = {"Brightness", "Brightness Down",
		exec("light -U 10")},
	low = {"Brightness", "Brightness Low",
		exec("light -S 20")},
	high = {"Brightness", "Brightness High",
		exec("light -S 100")},
}
local function set_titlebar(c, val)
	if val then
		awful.titlebar(c, {size = theme.titlebar_height})
	else
		awful.titlebar(c, {size = 0})
	end
end

local last_layout
local is_maximized = false
local maximize = { "Client", "Maximize Window",
	function(c)
		if c.floating then
			c.maximized = not c.maximized
			if c.maximized then
				awful.placement.bottom(c)
			else
				awful.placement.centered(c)
			end
			c:raise()
			return
		end
		local layout = awful.layout.get(c.screen)
		local is_maximized = layout == awful.layout.suit.max
		set_titlebar(c, is_maximized)
		if is_maximized then
			awful.layout.set(last_layout)
		else
			last_layout = layout
			awful.layout.set(awful.layout.suit.max)
		end
	end}
local fullscreen = {"Client", "Fullscreen",
	function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end}

local function switch_layout(i)
	if is_maximized then
		return
	end
	awful.layout.inc(i)
end

local function key(...)
	local mods = {...}
	local data = table.remove(mods) -- data:{group, description, press}
	local key = table.remove(mods)
	return awful.key(mods, key, data[3],
		{group=data[1], description=data[2]})
end
local function focus_direction(dir)
	awful.client.focus.bydirection(dir)
	if client.focus then client.focus:raise() end
end
local function toggle_dropdown(name)
	awful.screen.focused().dropdown[name]:toggle()
end
local function toggle_tag(name)
	local t = awful.tag.find_by_name(awful.screen.focused(), name)
	awful.tag.viewtoggle(t)
end
local function inc_width(c, factor)
	local s = c.screen
	local g = s:get_bounding_geometry()
	local inc = g.width * factor
	local clamped
	clamped, c.width = clamp_check(c.width + inc, math.abs(inc * 2), g.width)
	if clamped ~= -1 then
		c.x = clamp(c.x - (inc / 2), 0, g.width - c.width)
	end
end
local function inc_height(c, factor)
	local s = c.screen
	local g = s:get_bounding_geometry()
	local inc = g.height * factor
	local clamped
	clamped, c.height = clamp_check(c.height + inc, math.abs(inc * 2), g.height)

	if clamped ~= -1 then
		c.y = clamp(c.y - (inc / 2), 0, g.height - c.height)
	end
end
local function move_y(c, factor)
	local s = c.screen
	local g = s:get_bounding_geometry()
	local inc = g.height * factor
	c.y = clamp(c.y + inc, 0, g.height - c.height)
end
local function move_x(c, factor)
	local s = c.screen
	local g = s:get_bounding_geometry()
	local inc = g.width * factor
	c.x = clamp(c.x + inc, 0, g.width - c.width)
end
local function inc_tag(inc)
	local s = awful.screen.focused()
	local i = (tonumber(s.selected_tag.name) or 6) + inc
	if i < 1 then
		i = config.nr_normal_tags
	elseif i > config.nr_normal_tags then
		i = 1
	end

	awful.tag.viewnone(s)
	s.tags[i].selected = true
end
local home = os.getenv("HOME")
local function switch_kb_layout()
	awful.spawn.easy_async({"setxkbmap", "-query"},
		function(out, _, _, _)
			local curr = string.match(out, "layout:%s*(.-)\n")
			dlogf("c = '%s', '%s'", curr,config.main_kb_layout[1] )

			local layout
			if curr == config.main_kb_layout[1] then
				dlog("in primary")
				layout = config.secondary_layout
				awful.spawn({"xset", "led", config.kb_led})
			else
				layout = config.main_kb_layout
				awful.spawn({"xset", "-led", config.kb_led})
			end
			local cmd = {"setxkbmap"}
			table.insert(cmd, layout[1])
			if layout[2] then
				table.insert(cmd, "-variant")
				table.insert(cmd, layout[2])
			end
			awful.spawn(cmd)
			awful.spawn({"xmodmap", home.."/.xmodmaprc"})
		end)
end

M.globalkeys = awful.util.table.join(
	awful.key({}, "Menu", function() end),
	awful.key({shift}, "Menu", function() end),


	awful.key({mod, shift}, "Menu", function() switch_kb_layout() end),
	key(mod, "F1", {"Misc", "Show Help",
		hotkeys_popup.show_help}),

	key(mod, "BackSpace", {"Misc", "Clear notifications",
		function() naughty.destroy_all_notifications() end}),

	key(mod, ctrl, "BackSpace", {"Misc", "Restart Awesome",
		awesome.restart}),
	key(mod, ctrl, "r", {"Misc", "Restart Awesome",
		awesome.restart}),
	key(mod, ctrl, shift, "BackSpace", {"Misc", "Restart",
		exec("systemctl reboot")}),
	key(mod, ctrl, "Escape", {"Misc", "Quit Awesome",
		function() awesome.quit() end}),
	key(mod, ctrl, shift, "Escape", {"Misc", "Shutdown",
		exec("systemctl poweroff")}),

	--[[
	key(alt, "Tab", {"Movement", "View Last Window",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end}),
	]]--
	key(mod, "Tab", {"Movement", "Last Tags",
		awful.tag.history.restore}),

	key(mod, "h", {"Movement", "Previous Tag",
		function() inc_tag(-1) end}),--awful.tag.viewprev}),
	key(mod, "l", {"Movement", "Next Tag",
		function() inc_tag(1) end}),--awful.tag.viewnext}),
	key(mod, "j", {"Movement", "Next Window",
		function() awful.client.focus.byidx(1) end}),
	key(mod, "k", {"Movement", "Previous Window",
		function() awful.client.focus.byidx(-1) end}),

	key(mod, "Left", {"Movement", "Focus Left",
		function() focus_direction("left") end}),
	key(mod, "Right", {"Movement", "Focus Right",
		function() focus_direction("right") end}),
	key(mod, "Up", {"Movement", "Focus Up",
		function() focus_direction("up") end}),
	key(mod, "Down", {"Movement", "Focus Down",
		function() focus_direction("down") end}),

	key(mod, ctrl, shift, "Left", {"Layout", "Increase Number of Master Clients",
		function() awful.tag.incnmaster(1, nil, true) end}),
	key(mod, ctrl, shift, "Right", {"Layout", "Decrease Number of Master Clients",
		function() awful.tag.incnmaster(-1, nil, true) end}),
	key(mod, ctrl, shift, "Up", {"Layout", "Increase Number of columns",
		function() awful.tag.incncol(1, nil, true) end}),
	key(mod, ctrl, shift, "Down", {"Layout", "Decrease Number of columns",
		function() awful.tag.incncol(-1, nil, true) end}),


	key(mod, ctrl, shift, "h", {"Layout", "Increase Number of Master Clients",
		function() awful.tag.incnmaster(1, nil, true) end}),
	key(mod, ctrl, shift, "l", {"Layout", "Decrease Number of Master Clients",
		function() awful.tag.incnmaster(-1, nil, true) end}),
	key(mod, ctrl, shift, "k", {"Layout", "Increase Number of columns",
		function() awful.tag.incncol(1, nil, true) end}),
	key(mod, ctrl, shift, "j", {"Layout", "Decrease Number of columns",
		function() awful.tag.incncol(-1, nil, true) end}),


	key(mod, "b", {"Screen", "Focus Previous Screen",
		function() awful.screen.focus_relative(-1) end}),
	key(mod, "n", {"Screen", "Focus Next Screen",
		function() awful.screen.focus_relative(1) end}),

	key("XF86AudioPlay", music["toggle"]),
	key("XF86AudioNext", music["next"]),
	key("XF86AudioPrev", music["prev"]),
	key("XF86AudioRaiseVolume", vol["up"]),
	key("XF86AudioLowerVolume", vol["down"]),
	key("XF86AudioMute", vol["mute"]),
	key("XF86MonBrightnessUp", brightness["up"]),
	key("XF86MonBrightnessDown", brightness["down"]),

	key(mod, "Insert", music["prev"]),
	key(mod, shift, "Insert", music["beg"]),
	key(mod, "Home", music["next"]),

	key(mod, "Delete", music["bwd"]),
	key(mod, shift, "Delete", music["bbwd"]),
	key(mod, "End", music["fwd"]),
	key(mod, shift, "End", music["bfwd"]),

	key(mod, "Print", music["toggle"]),
	key(mod, shift, "Print", music["pause"]),
	key(mod, "Pause", vol["mute"]),
	key(mod, "Scroll_Lock", {"Misc", "Dropdown music player",
		function() toggle_dropdown("music") end}),


	key(mod, "Prior", vol["up"]),
	key(mod, shift, "Prior", vol["sup"]),
	key(mod, "Next", vol["down"]),
	key(mod, shift, "Next", vol["sdown"]),

	key(mod, "bracketleft", music["bwd"]),
	key(mod, shift, "bracketleft", music["bbwd"]),
	key(mod, "bracketright", music["fwd"]),
	key(mod, shift, "bracketright", music["bfwd"]),

	key(mod, "equal", vol["up"]),
	key(mod, shift, "equal", vol["sup"]),
	key(mod, "minus", vol["down"]),
	key(mod, shift, "minus", vol["sdown"]),

	key(mod, "p", music["toggle"]),
	key(mod, shift, "m", vol["mute"]),
	key(mod, shift, "z", music["beg"]),
	key(mod, "z", music["prev"]),
	key(mod, "x", music["next"]),

	key(mod, "period", brightness["up"]),
	key(mod, shift, "period", brightness["high"]),
	key(mod, "comma", brightness["down"]),
	key(mod, shift, "comma", brightness["low"]),

	key(mod, "Return", term),

	key(mod, "u", {"Movement", "Jump to urgent client",
		awful.client.urgent.jumpto}),
	key(mod, "space", {"Layout", "Select next layout",
		function() switch_layout(1) end}),

	key(mod, "w", browser1),
	key(mod, ctrl, "w", {"Tag", "Toggle tag W",
		function() toggle_tag("W") end}),
	key(mod, shift, "w", browser2),

	key(mod, "d", launcher1),
	key(mod, shift, "d", launcher2),

	key(mod, "i", {"Program", "Htop",
		exec_term(config.term, "htop")}),

	key(mod, shift, "p", {"Program", "KeePass",
		exec_tag_special("P")}),
	key(mod, ctrl, "p", {"Tag", "Toggle tag P",
		function() toggle_tag("P") end}),


	key(mod, "g", {"Program", "Gimp",
		exec_tag_special("G")}),
	key(mod, ctrl, "g", {"Tag", "Toggle tag G",
		function() toggle_tag("G") end}),

	key(mod, shift, "t", {"Program", "qBittorrent",
		exec_tag_special("T")}),
	key(mod, ctrl, "t", {"Tag", "Toggle tag T",
		function() toggle_tag("T") end}),

	key(mod, "e", {"Program", "Emacs",
		exec_tag_special("E")}),
	key(mod, ctrl, "e", {"Tag", "Toggle tag E",
		function() toggle_tag("E") end}),

	key(mod, "v", {"Program", "Vlc",
		exec_tag_special("V")}),
	key(mod, ctrl, "v", {"Tag", "Toggle tag V",
		function() toggle_tag("V") end}),


	key(mod, "a", {"Misc", "Big Dropdown Terminal",
		function() toggle_dropdown("big") end}),
	key(mod, "s", {"Misc", " Small Dropdown Terminal",
		function() toggle_dropdown("small") end}),

	key(mod, "t", {"Misc", "Edit Todo",
		function() toggle_dropdown("todo") end}),

	key(mod, "m", {"Misc", "Dropdown music player",
		function() toggle_dropdown("music") end}),

	key(mod, ctrl, "b", {"Widgets", "Show Battery Widget",
		function() theme.battery.show(5) end}),
	key(mod, ctrl, "n", {"Widgets", "Show Network Widget",
		function() theme.net.show(5) end}),
	--key(mod, ctrl, "c", {"Widgets", "Show Calendar Widget",
	--	function() lain.widget.calendar.show(5) end}),


	key(mod, ctrl, "equal", {"Misc", "Increment gaps",
		function() lain.util.useless_gaps_resize(1) end}),
	key(mod, ctrl, "minus", {"Misc", "Decrement gaps",
		function() lain.util.useless_gaps_resize(-1) end})
)


M.clientkeys = awful.util.table.join(
	key(mod, shift, "Left", {"Movement", "Swap Left / Floating Move Left",
		function(c)
			if c.floating then
				move_x(c, -0.025)
			else
				awful.client.swap.global_bydirection("left")
			end
		end}),
	key(mod, shift, "Right", {"Movement", "Swap Right / Floating Move Right",
		function(c)
			if c.floating then
				move_x(c, 0.025)
			else
				awful.client.swap.global_bydirection("right")
			end
		end}),
	key(mod, shift, "Up", {"Movement", "Swap Up / Floating Move Up",
		function(c)
			if c.floating then
				move_y(c, -0.025)
			else
				awful.client.swap.global_bydirection("up")
			end
		end}),
	key(mod, shift, "Down", {"Movement", "Swap Down / Floating Move Down",
		function(c)
			if c.floating then
				move_y(c, 0.025)
			else
				awful.client.swap.global_bydirection("down")
			end
		end}),

	key(mod, shift, "h", {"Layout", "Floating Move Left",
		function(c)
			if c.floating then
				move_x(c, -0.025)
			end
		end}),
	key(mod, shift, "l", {"Layout", "Floating Move Right",
		function(c)
			if c.floating then
				move_x(c, 0.025)
			end
		end}),
	key(mod, shift, "j", {"Layout", "Swap with next client by index / Floating Move Down",
		function(c)
			if c.floating then
				move_y(c, 0.025)
			else
				awful.client.swap.byidx(1)
			end
		end}),
	key(mod, shift, "k", {"Layout", "Swap with next client by index / Floating Move Up",
		function(c)
			if c.floating then
				move_y(c, -0.025)
			else
				awful.client.swap.byidx(-1)
			end
		end}),


	key(mod, ctrl, "Left", {"Layout", "Decrease Master/Floating Width",
		function(c)
			if c.floating then
				inc_width(c, -0.05)
			else
				awful.tag.incmwfact(-0.05)
			end
		end}),
	key(mod, ctrl, "Right", {"Layout", "Increase Master/Floating Width",
		function(c)
			if c.floating then
				inc_width(c, 0.05)
			else
				awful.tag.incmwfact(0.05)
			end
		end}),
	key(mod, ctrl, "Up", {"Layout", "Increase Client/Floating Height",
		function(c)
			if c.floating then
				inc_height(c, 0.05)
			else
				awful.client.incwfact(0.05)
			end
		end}),
	key(mod, ctrl, "Down", {"Layout", "Decrease Client/Floating Height",
		function(c)
			if c.floating then
				inc_height(c, -0.05)
			else
				awful.client.incwfact(-0.05)
			end
		end}),

	key(mod, ctrl, "h", {"Layout", "Decrease Master/Floating Width",
		function(c)
			if c.floating then
				inc_width(c, -0.05)
			else
				awful.tag.incmwfact(-0.05)
			end
		end}),
	key(mod, ctrl, "l", {"Layout", "Increase Master/Floating Width",
		function(c)
			if c.floating then
				inc_width(c, 0.05)
			else
				awful.tag.incmwfact(0.05)
			end
		end}),
	key(mod, ctrl, "k", {"Layout", "Increase Client/Floating Height",
		function(c)
			if c.floating then
				inc_height(c, 0.05)
			else
				awful.client.incwfact(0.05)
			end
		end}),
	key(mod, ctrl, "j", {"Layout", "Decrease Client/Floating Height",
		function(c)
			if c.floating then
				inc_height(c, -0.05)
			else
				awful.client.incwfact(-0.05)
			end
		end}),

	key("F11", maximize),
	key(shift, "F11", fullscreen),
	key(mod, shift, "space", {"Client", "Toggle floating",
		function(c) lain.util.magnify_client(c); c:raise() end }),

	key(mod, "f", maximize),
	key(mod, shift, "f", fullscreen),

	key(mod, "q", {"Client", "Close",
		function(c) c:kill() end}),
	key(mod, shift, "q", {"Client", "Kill", -- used in extreme cases
		function(c)
			awful.spawn.with_shell("xkill -id `xprop -root _NET_ACTIVE_WINDOW | cut -d\\# -f2`")
		end}),

	key(mod, "grave", {"Client", "Move to master",
		function(c) c:swap(awful.client.getmaster()) end}),
	key(mod, ctrl, "o", {"Client", "Move to screen",
		function(c) c:move_to_screen() end}),
	key(mod, ctrl, "a", {"Client", "Toggle keep on top",
		function(c) c.ontop = not c.ontop end})

	--key(mod, alt}, "n", {"Test - Client", "Minimize",
	--	function(c) c.minimized = true end}),

)

for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = {description = "View Tag #", group = "Tag"}
		descr_toggle = {description = "Toggle tag #", group = "Tag"}
		descr_move = {description = "Move focused client to tag #", group = "Tag"}
		descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
	end
	M.globalkeys = awful.util.table.join(M.globalkeys,
		-- View tag only.
		awful.key({mod}, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						tag:view_only()
						--[[if screen.clients[1] then
							screen.clients[1]:raise()
						end]]
					end
				end,
				descr_view),
		-- Toggle tag display.
		awful.key({mod, ctrl}, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
				descr_toggle),
		-- Move client to tag.
		awful.key({mod, shift}, "#" .. i + 9,
				function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
							tag:view_only()
						end
					end
				end,
				descr_move),
		-- Toggle tag on focused client.
		awful.key({mod, ctrl, shift}, "#" .. i + 9,
				function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:toggle_tag(tag)
						end
					end
				end,
				descr_toggle_focus)
	)
end

return M
