local awful         = require("awful")
local beautiful     = require("beautiful")
local freedesktop   = require("freedesktop")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local yaml          = require("yaml")

require("utils")
local M = {}

M.icons_dir = os.getenv("HOME").."/.config/awesome/icons/"
M.theme_icons_dir = os.getenv("HOME").."/.config/awesome/papirus-icon-theme/Papirus/16x16/panel/"
M.titlebar_icons_dir = os.getenv("HOME").."/.config/awesome/papirus-icon-theme/Papirus/16x16/actions/"
local file = os.getenv("HOME").."/.config/colors/colors"

--local content = read_file(file)
M.colors = yaml.load(read_file(file)) or {
	base00 = "000000", -- Black
	base01 = "303030",
	base02 = "404040",
	base03 = "808080", -- Bright Black
	base04 = "B0B0B0",
	base05 = "E0E0E0", -- White
	base06 = "F0F0F0",
	base07 = "FFFFFF", -- Bright White
	base08 = "FF0000", -- Red
	base09 = "FF8000", -- Orange
	base0A = "FFFF00", -- Yellow
	base0B = "00FF00", -- Green
	base0C = "0080FF", -- Cyan
	base0D = "0000FF", -- Blue
	base0E = "8000FF", -- Magenta
	base0F = "0080FF",
}
M.colors.black    = M.colors.base00
M.colors.white    = M.colors.base07
M.colors.red      = M.colors.base08
M.colors.orange   = M.colors.base09
M.colors.yellow   = M.colors.base0A
M.colors.green    = M.colors.base0B
M.colors.cyan     = M.colors.base0C
M.colors.blue     = M.colors.base0D
M.colors.magenta  = M.colors.base0E

M.colors.bg_dark   = M.colors.black
M.colors.bg_light  = M.colors.base02
M.colors.fg_gray   = M.colors.base03
M.colors.fg_normal = M.colors.base05
M.colors.fg_focus  = M.colors.orange

M.default_font = "UbuntuMono Nerd Font 9"-- "DejaVu Sans 9" "Droid Sans Mono 9"-- --"xos4 Terminus 9"
M.bar_font = "UbuntuMono Nerd Font 11"

M.kb_led = "3"
--                   {layout, variant}
M.main_kb_layout   = {"us"}
M.secondary_layout = {"ro", "std"}

M.term = "urxvt"
M.music = "ncmpcpp"
M.editor = "vim"
M.geditor = "tvim"

-- tables of form { when, cmd }
-- when can be:
--     once: called if no instances were found
--     once_sh: same as once
--     start: called if awesome was started from xinit or startx
--     start_sh: same as start but called with shell
--     start_fn: call function if awesome was started from xinit or startx
--     always: everytime rc.lua gets evaluated
--     always_sh: same as always but called with shell
--     always_fn: call function always
M.autorun = {
	{ "once", "unclutter -root" },
	{ "once", "compton -b --config ~/.config/compton.conf" },
	{ "once", "mpd ; mpc pause" },
    -- { "once", "emacs --daemon"},
	-- { "start", "mpc pause" },
	{ "start_fn", function()
		awful.spawn(sprintf("%s -e sh -c '~/bin/daily_msg; %s'",
			M.term, os.getenv("SHELL")))
		end},

}
M.program_rules = {
	{ rule_any = { type = { "dialog", "normal" } },
	  properties = { titlebars_enabled = true } },
    { rule = { class = "qt_ts" },
      properties = { floating=true } },
}

M.nr_normal_tags = 5
M.special_tags_order = {"W", "G", "P", "T", "E", "V" }
M.special_tags = {
	--tag = {command, class, role-for-primary}
	W = {"qutebrowser", "qutebrowser"},
	G = {"gimp", "Gimp", "gimp-image-window"},
	P = {"keepass", "KeePass2"},
	T = {"qbittorrent", "qBittorrent"},
	V = {"vlc", "Vlc", "vlc-main"},
	E = {"emacs", "Emacs"},
}
M.tags = {}
for i=1, M.nr_normal_tags do
	table.insert(M.tags, tostring(i))
end
for _, tag in ipairs(M.special_tags_order) do
	local data = M.special_tags[tag]
	table.insert(M.tags, tag)

	table.insert(M.program_rules, {
		rule = {class = data[2], role = data[3]},
		properties = {
			tag = tag,
			switchtotag = true,
			titlebars_enabled = false,
		}
	})
	if data[3] then
		table.insert(M.program_rules, {
			rule = {class = data[2]},
			properties = {
				tag = tag,
				switchtotag = true,
			}
		})
	end
end

--Get a function that spawns cmd if tag is empty and moves to that tag
function exec_tag_special(tag)
	return function()
		local data = M.special_tags[tag]
		local s = awful.screen.focused()
		local t = awful.tag.find_by_name(s, tag)
		local cl
		for _, c in ipairs(client.get()) do
			if c.class == data[2] then
				cl = c
				break
			end
		end

		if cl then
			cl:move_to_tag(t)
			cl:raise()
		else
			awful.spawn(data[1], {tag=t})
		end
		t:view_only()
	end
end
--table.insert(M.tags, "Hidden")

local alpha_bg = "-bg [90]#"..M.colors.black
function M.get_dropdowns()
	return {
		small = lain.util.quake({
			app = M.term,
			extra = alpha_bg.." -cd ~/Projects/qt_ts",
			name = "QuakeDD_small",
			height = 0.7,
			width = 0.7,
			vert = "center",
			horiz = "center",
		}),
		big = lain.util.quake({
			app = M.term,
			extra = alpha_bg.." -cd ~/",
			name = "QuakeDD_big",
			height = 0.9,
			width = 0.9,
			vert = "center",
			horiz = "center",
		}),
		music = lain.util.quake({
			app = M.term,
			name = "QuakeDD_music",
			extra = "-e ".. M.music,
			height = 1, --0.95,
			width = 0.8,
			vert = "center",
			horiz = "center",
		}),
		todo = lain.util.quake({
			app = M.term,
			extra = alpha_bg.." -e sh -c 'sh ~/.colors/shell; nvim ~/todo.org'",
			name = "QuakeDD_todo",
			height = 0.9,
			width = 0.55,
			vert = "center",
			horiz = "center",
		}),
	}
end



M.layouts = {
	--awful.layout.suit.floating,
	awful.layout.suit.tile,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	--awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier,
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.corner.ne,
	--awful.layout.suit.corner.sw,
	--awful.layout.suit.corner.se,
	--lain.layout.cascade,
	--lain.layout.cascade.tile,
	--lain.layout.centerwork,
	--lain.layout.centerwork.horizontal,
	--lain.layout.termfair,
	--lain.layout.termfair.center,
}



lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

return M
