local awful   = require("awful")
local wibox   = require("wibox")
local helpers = require("lain.helpers")
local config  = require("config")
local naughty = require("naughty")
local lain    = require("lain")

require("utils")
local M = {
	widget = wibox.widget {
		font = config.top_font,--bar_font,
		widget = wibox.widget.textbox
	}
}
function M.update()
	local hour = os.date("*t").hour
	local color = config.colors.fg_normal
	if hour >= 23 then
		color = config.colors.orange
	end

	M.widget:set_markup(os.date("%a %d %b ".. markup(color, "%R")))
end

helpers.newtimer("date-time", 30, M.update)

return M
