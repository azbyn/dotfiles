local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")

--local imagebox_multi = require("widgets/imagebox_multi")
require("utils")


local M = { }

M.text = wibox.widget {
    --font = "Noto Color Emoji 11",-- config.top_font,
    font = config.top_font,
    widget = wibox.widget.textbox,
    color = config.colors.fg_normal
}

local command = "swapon --noheadings --show=USED"

function M.update()
    awful.spawn.easy_async(command,
    function(stdout, _, _, _)
        --M.widget:set_color(col)
        M.text:set_text(stdout:gsub("%s+", ""))
    end)
end
M.update()--check on load
helpers.newtimer("swap_", 60, M.update)-- once every minute

return M

