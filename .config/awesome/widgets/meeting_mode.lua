local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
local naughty  = require("naughty")
require("utils")

local M = {}

M.text = wibox.widget {
   font = config.top_font,
   widget = wibox.widget.textbox,
   text = "oi"
}

function toggle_meeting_mode ()
   naughty.toggle()
   if naughty.is_suspended() then
      naughty.destroy_all_notifications()
   end
   M.update_text()
end

function M.update_text()
   if naughty.is_suspended() then
      M.text:set_markup(markup(config.colors.blue, "щ"))
   else
      M.text:set_markup("")
   end
end

M.update_text()

return M
