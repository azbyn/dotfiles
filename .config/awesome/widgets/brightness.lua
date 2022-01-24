local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
-- local naughty   = require("naughty")
local imagebox = require("widgets.imagebox")

require("utils")

local M = {}

M.icon = imagebox()--config.icons_dir.."/brightness.png")
M.icon:set_image(config.icons_dir.."brightness.png", config.colors.fg_normal)


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


function M.exec(cmd)
   return function()
      -- awful.spawn(cmd)
      M.update(cmd)
   end
end

function M.update(cmd)
   if cmd then
      cmd = cmd .. "&& light"
   else
      cmd = "light"
   end
   
   awful.spawn.easy_async_with_shell(cmd,-- .."&& xbacklight",
                          function(out, _, _, _)
                             local val = tonumber(out)
                             local color = config.colors.orange
                             M.arc.colors = { "#"..color }
                             M.arc.value = val
                             -- naughty.notify({text="Brightness: "..val})
                          end
   )
end

M.update()
-- helpers.newtimer("brightness", 60, M.update)
return M
