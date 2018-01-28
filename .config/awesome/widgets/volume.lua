local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")

require("utils")

local MUTE = config.icons_dir.."volume-muted.png"--icons_dir.."vol_no.png"--"vol_mute.png"
local NONE = config.icons_dir.."volume-none.png"--config.icons_dir.."vol_no.png"
local LOW  = config.icons_dir.."volume-low.png"--config.icons_dir.."vol_low.png"
local MED  = config.icons_dir.."volume-medium.png"--config.icons_dir.."vol_low.png"
local HIGH = config.icons_dir.."volume-high.png"--config.icons_dir.."vol.png"

local CMD_TEMPLATE = "amixer get Master"
local M = {}
M.icon = imagebox(LOW)

M.arc = wibox.widget {
	wibox.container.mirror(M.icon, { horizontal = true }),
	--rounded_edge = true,
	max_value = 100,
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


function M.call(cmd)
	return function() M.update(cmd) end
end

function M.update(cmd)
	if cmd then
		cmd = sprintf("%s > /dev/null; %s", cmd, CMD_TEMPLATE)
	else
		cmd = CMD_TEMPLATE
	end
	awful.spawn.easy_async_with_shell(cmd,
		function(out, _, _, _)
			local vol, state = string.match(out, "([%d]+)%%.*%[([%l]*)%]")
			--is this check even needed?
			--if vol == M.last.vol and state == M.last.state then return end
			-- M.last = { vol, state }
			vol = tonumber(vol)
			local color
			if state ~= "on" then
				color = config.colors.blue
				M.icon:set_image(LOW, config.colors.cyan) --MUTE
			elseif vol >= 66 then
				color = config.colors.orange
				M.icon:set_image(HIGH, config.colors.yellow)
			elseif vol >= 33 then
				color = config.colors.orange
				M.icon:set_image(MED, config.colors.fg_normal)
			elseif vol == 0 then
				color = config.colors.fg_normal
				M.icon:set_image(NONE, config.colors.fg_normal)--config.colors.fg_gray)
			else
				color = config.colors.yellow
				M.icon:set_image(LOW, config.colors.fg_normal)--config.colors.fg_normal)
			end
			M.arc.colors = { "#"..color }
			M.arc.value = vol
			--M.text:set_markup(markup(color, sprintf(" %d%% ", vol)))
		end)
end
helpers.newtimer("volume", 10, M.update)
--M.update()
return M
