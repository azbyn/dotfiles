local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")
--local dbus     = require("dbus")

--local imagebox_multi = require("widgets/imagebox_multi")
require("utils")


local M = { }

M.widget = imagebox(config.icons_dir.."messages.png", config.colors.fg_normal)

M.text = wibox.widget {
    font = config.top_font,
    widget = wibox.widget.textbox,
    color = config.colors.fg_normal,
    text = ""
}

local function updateConnected(val)
    if val then
        M.text.text = "0"
        M.widget:set_color(config.colors.fg_normal)
    else
        M.text.text = ""
        M.widget:set_color(config.colors.base03)
    end
end

updateConnected(file_exists("/tmp/scli_running"))

dbus.request_name("session", "org.azbyn.scli")
local function callback(data, count)
    if data.member == "Connect" then
        updateConnected(true)
    elseif data.member == "Disconnect" then
        updateConnected(false)
    else
        M.text.text = count
        local col = config.colors.fg_normal
        if count > 0 then
            col = config.colors.orange
        end
        M.widget:set_color(col)
    end
end
dbus.connect_signal("org.azbyn.scli", callback)

return M

