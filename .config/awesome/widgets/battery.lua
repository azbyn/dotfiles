local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")
require("utils")

local AC   = config.icons_dir.."ac.png"
local HI   = config.icons_dir.."battery.png"
local LOW  = config.icons_dir.."battery_low.png"
local NONE = config.icons_dir.."battery_empty.png"

local CRIT_PERCENT = 15
local LOW_PERCENT  = 35
local FULL_PERCENT = 95
local M = { last={charge=100, pluggedin=true} }

M.icon = imagebox(NONE, config.colors.fg_normal)

M.arc = wibox.widget {
	wibox.container.mirror(M.icon, { horizontal = true }),
	--rounded_edge = true,
	max_value = 100,
	thickness = 2,-- 1.5,
    start_angle = math.pi * 1.5,
	forced_height = 19,--17,
	forced_width = 19,--17,
	bg = "#"..config.colors.base03,
	colors = { "#"..config.colors.fg_focus },
	paddings = 2,
	widget = wibox.container.arcchart,
}
M.widget = wibox.container.mirror(M.arc, { horizontal = true })

function M.show(timeout)
	M.update()
	M.hide()
	M.notification = naughty.notify({
		bg          = "#"..config.colors.bg_light,
		fg          = "#"..config.colors.fg_focus,
		font        = "DejaVu Sans Mono 10",
		timeout     = timeout or 5,
		text        = sprintf("%d%%, %s", M.last.charge, M.last.time),
	})
end
function M.hide()
	if not M.notification then return end
	naughty.destroy(M.notification)
	M.notification = nil
end

M.widget:connect_signal('mouse::enter', function() M.show(0) end)
M.widget:connect_signal('mouse::leave', function() M.hide() end)


local function notify(title, text, col)
	M.id = naughty.notify({
		title       = title,
		text        = text,
		timeout     = 15,
		replaces_id = M.id,
		bg          = "#"..config.colors.bg_light,
		fg          = "#"..col,-- config.colors.red,
		font        = "DejaVu Sans Mono 14",
	}).id
end

function M.update()
	awful.spawn.easy_async({"acpi", "-b"},
		function(out, _, _, _)
			--out = "Battery 0: Discharging, 95%, 00:25:16 remaining\n"
			local status, charge, time = string.match(out, ".-: (.-), (.*)%%,? ?(.-)")
			local color
			local data = {time = time ~="" and time or (status or "") }

			if status then
				data.charge = tonumber(charge)
				local icon
				if data.charge <= CRIT_PERCENT then
					icon = NONE
					color = config.colors.orange
				elseif data.charge <= LOW_PERCENT then
					icon = LOW
					color = config.colors.yellow
				else
					icon = HI
					color = config.colors.green
				end
				if status == "Charging" then
					data.pluggedin = true
                    if data.charge >= FULL_PERCENT then
					    M.icon:set_image(AC, config.colors.cyan)
                    else
					    M.icon:set_image(AC, config.colors.fg_gray)
                    end
				elseif status == "Full" then
					data.pluggedin = true
					color = config.colors.blue
					M.icon:set_image(AC, config.colors.fg_normal)
				else
					if data.charge <= CRIT_PERCENT and M.last.charge > CRIT_PERCENT then
						notify("Battery critical!", time, config.colors.red)
					elseif data.charge <= LOW_PERCENT and M.last.charge > LOW_PERCENT then
						notify("Battery low!", time, config.colors.orange)
					elseif M.last.pluggedin then
						notify("On battery power! ("..charge.."%)", time, config.colors.yellow)
					end
					data.pluggedin = false
					M.icon:set_image(icon, config.colors.orange)
				end
			else -- no battery
				data.charge = 0
				data.plugedin = true
				color = config.colors.fg_gray
				M.icon:set_image(AC, config.colors.fg_normal)
			end
			M.last = data
			M.arc.value = data.charge
			M.arc.colors = {"#"..color}
		end)
end
helpers.newtimer("bat_", 20, M.update)

return M

