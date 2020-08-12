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
    font = config.top_font,
    widget = wibox.widget.textbox,
    color = config.colors.fg_normal,
    text = " "
}

M.setKey = function(val) M.text.text = val end

return M

