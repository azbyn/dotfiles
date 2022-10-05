local awful   = require("awful")
local wibox   = require("wibox")
local helpers = require("lain.helpers")
local config  = require("config")
local naughty = require("naughty")
local lain    = require("lain")

local email = require("widgets/email")
require("utils")
local M = {
	widget = wibox.widget {
		font = config.top_font,--bar_font,
		widget = wibox.widget.textbox
	}
}
M.updated_email = false
function M.update()
    local table = os.date("*t")
	local hour = table.hour
	--local minute = table.min
	local color = config.colors.fg_normal
	if hour >= 23 then
		color = config.colors.orange
	end
    --if minute % 30 == 0 then
    --    if not M.updated_email then
    --        email.update()
    --        M.updated_email = true
    --    end
    --else
    --    M.updated_email = false
    --end
	M.widget:set_markup(os.date("%a %d %b ".. markup(color, "%R")))
    --local before = collectgarbage("count")
    collectgarbage("step", 4000)
    --collectgarbage()
    --local after = collectgarbage("count")
    --local delta = before - after
    --if delta > 0 then
    --    naughty.notify({text=sprintf("GC: bfore: %.0f, after: %.0f, delta: %.0f",before, after, delta)})
    --end
end

helpers.newtimer("date-time", 10, M.update)

return M
