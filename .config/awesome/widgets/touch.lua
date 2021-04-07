local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local gears    = require("gears")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")

require("utils")

local M = { }

M.widget = imagebox(config.icons_dir.."touch.png", config.colors.fg_normal)
-- M.widget:buttons( awful.util.table.join( awful.button({ }, 1, function() M.toggle()  end) ))

local device_id = "SYNAPTICS Synaptics Touch Digitizer V04"

function M.is_enabled_async(func)
   awful.spawn.easy_async({"xinput", "list-props", device_id},--script,
      function(stdout, _, _, _)
         for res in string.gmatch(stdout, "Device Enabled .-:%s+(%d+)") do
            func(res=="1")
            return
         end
      end
   )
end

function M.toggle()
     M.is_enabled_async(function (enabled)
         local str = "disable"
         if not enabled then
            str = "enable"
         end
         
         awful.spawn({"xinput", str, device_id})
         update(not enabled)
   end)
   -- awful.spawn.easy_async({"xinput", "list-props", device_id},--script,
end
function M.disable()
     M.is_enabled_async(function (enabled)
         local str = "disable"
         if not enabled then
            return
         end
         
         awful.spawn({"xinput", str, device_id})
         update(not enabled)
   end)
   -- awful.spawn.easy_async({"xinput", "list-props", device_id},--script,
end

function update(enabled)
   local col = config.colors.fg_normal
   if not enabled then
      col = config.colors.fg_gray-- orange
   end
   M.widget:set_color(col)
end

-- M.is_enabled_async(update)
-- todo, fix, we have a "sleep 1, so we can't do it at first"
update(false)

-- helpers.newtimer("email_", 1 * 60 * 60, M.update)-- once every 1 hr

gears.timer {
   timeout = 5,
   -- call_now = true,
   autostart = true,
   single_shot = true,
   callback = function ()
      M.disable()
   end
}

return M
