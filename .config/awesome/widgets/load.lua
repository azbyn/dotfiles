local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
require("utils")

local M = {}
--M.icon = imagebox(config.icons_dir.."temp.png", config.colors.fg_normal)
M.text = wibox.widget {
	font = config.top_font,
	widget = wibox.widget.textbox
}
M.nr_cores = 2

function M.update()
	-- load for 1, 5 and 15 minutes
	local l1, l5, l15 = string.match(
		read_file("/proc/loadavg"),
		"(.-) (.-) (.-) ")
	-- change this if you want
	local l = tonumber(l5)
	local color
	if l >= M.nr_cores * 0.75 then
		color = config.colors.yellow
	elseif l >= M.nr_cores * 1.5 then
		color = config.colors.orange
	else
		color = config.colors.fg_normal
	end
	M.text:set_markup(markup(color, sprintf("%.2f", l)))

end
helpers.newtimer("load", 30, M.update)

return M

