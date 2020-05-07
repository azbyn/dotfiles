local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")

--local imagebox_multi = require("widgets/imagebox_multi")
require("utils")


--local WIFI_00  = 
--local ICON  = config.icons_dir.."mail.png"
local M = { }

M.widget = imagebox(config.icons_dir.."mail.png", config.colors.fg_normal)

M.text = wibox.widget {
    font = config.top_font,
    widget = wibox.widget.textbox,
    color = config.colors.fg_normal
}

--taken from:
--https://github.com/streetturtle/awesome-wm-widgets/blob/master/email-widget/count_unread_emails.py
local script = os.getenv("HOME").."/.config/awesome/count_unread_emails.py"

function M.update()
    awful.spawn.easy_async(script,
    function(stdout, _, _, _)
        local count = tonumber(stdout)
        local col = config.colors.fg_normal
        local txt = count
        if count > 0 then
            col = config.colors.orange
        else
            txt = ""
        end
        M.widget:set_color(col)
        M.text:set_text(count)
    end)
end
--M.update()--check on load
helpers.newtimer("email_", 1 * 60 * 60, M.update)-- once every 1 hr

return M

