local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
require("utils")

local M = {}
M.icon = imagebox(config.icons_dir.."ram.png", config.colors.fg_normal)

M.arc = wibox.widget {
	wibox.container.mirror(M.icon, { horizontal = true }),
	--rounded_edge = true,
	max_value = 1,
	thickness = 2,-- 1.5,
	start_angle = math.pi * 1.5,
	forced_height = 17,
	forced_width = 17,
	bg = "#"..config.colors.base03,
	colors = { "#"..config.colors.fg_focus },
	paddings = 2,
	widget = wibox.container.arcchart,
}
M.widget = wibox.container.mirror(M.arc, { horizontal = true })

-- doing this in perl is easier (at least for me) and doesn't require a shell
local SCRIPT = [[
@out = split / +/, (split /\n/, `free`)[1];
print $out[2] / $out[1];]]

function M.update()
	awful.spawn.easy_async({ "perl", "-e", SCRIPT },
		function(out, _, _, _)
			local perc = tonumber(out)
			local color
			if perc >= 0.6 then
				color = config.colors.yellow
			elseif perc >= 0.85 then
				color = config.colors.orange
			else
				color = config.colors.fg_normal
			end
			M.arc.value = perc
			M.icon:set_color(color)
		end)
end
helpers.newtimer("ram", 40, M.update)

return M
