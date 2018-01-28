local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
require("utils")

local M = { }

M.icon = imagebox(config.icons_dir.."cpu.png", config.colors.fg_normal)

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

function M.update()
	local time = helpers.lines_match("^cpu ","/proc/stat")[1]

	local data   = M.data or
				   { last_active = 0 , last_total = 0, usage = 0 }
	local at     = 1
	local idle   = 0
	local total  = 0

	for field in string.gmatch(time, "[%s]+([^%s]+)") do
		-- 4 = idle, 5 = ioWait. Essentially, the CPUs have done
		-- nothing during these times.
		if at == 4 or at == 5 then
			idle = idle + field
		end
		total = total + field
		at = at + 1
	end

	local active = total - idle

	if data.last_active ~= active or data.last_total ~= total then
		-- Read current data and calculate relative values.
		local dactive = active - data.last_active
		local dtotal  = total - data.last_total
		local usage   = dactive / dtotal

		data.last_active = active
		data.last_total  = total
		data.usage       = usage

		-- Save current data for the next run.
		M.data = data
	end

	local color
	if M.data.usage >= 0.6 then
		color = config.colors.yellow
	elseif M.data.usage >= 0.85 then
		color = config.colors.orange
	else
		color = config.colors.fg_normal
	end
	M.arc.value = M.data.usage
	M.icon:set_color(color)
end

helpers.newtimer("cpu_", 20, M.update)

return M
