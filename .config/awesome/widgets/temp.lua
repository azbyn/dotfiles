local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
require("utils")

local M = {}
--M.icon = imagebox(config.icons_dir.."temp.png", config.colors.fg_normal)
M.text = wibox.widget {
	font = config.bar_font,
	widget = wibox.widget.textbox
}

function M.update()
	awful.spawn.easy_async({"sensors"},
		function(out, _, _, _)
			local temp = 0
			local i = 0
			for t in string.gmatch(out, "Core %d:%s*(.-)°C") do
				temp = temp + tonumber(t)
				i = i + 1
			end
			temp = math.floor(temp / i)
			local color
			if temp >= 70 then
				color = config.colors.yellow
			elseif temp >= 80 then
				color = config.colors.orange
			else
				color = config.colors.fg_normal
			end
			--M.icon:set_color(color)
			M.text:set_markup(markup(color, sprintf("%d°C", temp)))
	end)
end
helpers.newtimer("temp_", 30, M.update)

return M
