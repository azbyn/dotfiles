local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local naughty  = require("naughty")
local config   = require("config")
local imagebox = require("widgets.imagebox")
local escape   = require("awful.util").escape --require("gears.string").escape
local rex      = require("rex_pcre")
local utf8     = require("utf8_simple")
require("utils")

local PASSWORD = nil
local HOST = "127.0.0.1"
local PORT = "6600"
local TITLE_MAX = 25
local ARTIST_MAX = 18

PASSWORD = (PASSWORD and #PASSWORD > 0) and
   sprintf("password %s\\n", PASSWORD) or ""
local CMD_TEMPLATE = sprintf([[printf "%sstatus\ncurrentsong\nclose\n"]]..
   [[| curl --connect-timeout 1 -fsm 3 telnet://%s:%s]],
   PASSWORD, HOST, PORT)

local M = {}
M.text = wibox.widget {
   font = config.top_font,
   widget = wibox.widget.textbox
}
M.arc_text = wibox.widget {
   --id = "txt",
   font = "Ubuntu Mono 14",-- config.top_font,-- #"11",
   align = "left",
   --valign = "center",
   valign = "bottom",
   widget = wibox.widget.textbox
}
M.arc = wibox.widget {
   wibox.container.mirror(M.arc_text, { horizontal = true }),
   --text_with_background,
   --wibox.container.background(arc_text),
   --rounded_edge = true,
   thickness = 2.5,-- 1.5,
   start_angle = math.pi * 1.5,
   max_value = 1,
   forced_height = 17,
   forced_width = 17,
   bg = "#"..config.colors.base03,
   colors = { "#"..config.colors.fg_focus },
   paddings = 2,
   widget = wibox.container.arcchart,
}
M.mirrored_arc = wibox.container.mirror(M.arc, { horizontal = true })

--mpd_notification_preset = { title = "Now playing", timeout = 5 }
--M.last = nil

function M.call(cmd)
   return function() M.update(cmd) end
end

function M.next() return M.call("mpc next") end

function M.next()   return M.call("mpc next") end
function M.prev()   return M.call("mpc prev") end
function M.toggle() return M.call("mpc toggle") end
function M.pause()  return M.call("mpc pause") end
function M.fwd()    return M.call("mpc seek +5") end
function M.bfwd()   return M.call("mpc seek +30") end
function M.bwd()    return M.call("mpc seek -5") end
function M.bbwd()   return M.call("mpc seek -30") end
function M.beg()    return M.call("mpc seek 0%") end

function M.update(cmd)
   if cmd then
      cmd = sprintf("%s > /dev/null; %s", cmd, CMD_TEMPLATE)
   else
      cmd = CMD_TEMPLATE
   end
   awful.spawn.easy_async_with_shell(
      cmd,
      function(stdout, _, _, _)
         local out = {}
         for line in string.gmatch(stdout, "[^\n]+") do
            local k, v = line:match("(%w+): (.*)")
            if k then
               out[k] = v
            end
         end
         local file = out.file
         local artist = out.Artist
         local title = out.Title
         local album = out.Album
         local track = out.Track
         local date  = out.Date
         if file then
            local dir, _album, _artist, _track, _title = rex.match(file,
                                                                   '(?:(.*?)/)?'..   --dir
                                                                   '(?:(.*?)/)?'..   --album dir
                                                                   '(?:.*/)?'..      --misc dirs
                                                                   '(?:(.*?) - )?'.. --artist
                                                                   '(?:(\\d+) - )?'..--track
                                                                   '(.*)'..          --title
                                                                   '\\.(.*)')        --extension
            if not artist then
               artist = _artist and trim(_artist) or
                  (_album and trim(_album) or "")
                   -- (dir and trim(dir) or ""))
               -- a nice fix
               if artist == "ACDC" then artist = "AC/DC" end
            end
            if not title then
               title = _title and trim(_title) or "N/A"
            end
            if not album then
               album = _album and trim(_album)
            end
            if not track then
               track = _track and _track
            end
         end
         if date then album = album.." - "..date end
         local function get_arc_text(s)
            local levels = { '█', '▉', '▊', '▋', '▌','▍', '▎', '▏', }
            return levels[math.floor(s / 2) + 1]
         end
         --local time

         if out.elapsed and out.duration then
            local elapsed = tonumber(out.elapsed) or 0
            local duration = tonumber(out.duration) or 1
            M.arc.value = elapsed
            M.arc.max_value = duration
            --[[
               if elapsed <= 16 then
               M.arc_text.text = get_arc_text(elapsed)
               elseif duration - elapsed <= 16 then
               M.arc_text.text = get_arc_text(duration - elapsed)
               else
               M.arc_text.text = ""
               end
               M.arc_text.text = ""
            ]]--
            --time = sec_to_min_sec(duration)
            --time = sec_to_min_sec(elapsed).."/"..sec_to_min_sec(duration)
         else
            M.arc.value = 0
            M.arc.max_value = 1
            --M.arc_text.text = ""
            --time = ""
         end

         --M.arc_text.text = markup(config.colors.fg_focus, "█")

         local colors = {
            artist = config.colors.fg_normal,
            title  = config.colors.fg_normal,
            --time   = config.colors.fg_normal,
         }

         if out.state == "play" then
            colors.artist = config.colors.fg_focus

         elseif out.state == "pause" then
            colors.title = config.colors.fg_gray
            --colors.time  = config.colors.fg_gray
         else
            colors.artist = config.colors.fg_gray
            colors.title  = config.colors.fg_gray
            --colors.time   = config.colors.fg_gray

            M.text.text = ""
            return
         end

         if utf8.len(artist) > ARTIST_MAX then
            artist = utf8.sub(artist, 0, ARTIST_MAX - 1).."…"
         end
         local rem = TITLE_MAX + ARTIST_MAX - utf8.len(artist)
         if utf8.len(title) > rem then
            title = utf8.sub(title, 0, rem - 1).."…"
         end
         M.text:set_markup(
            markup(colors.artist, escape(artist)).. " "..
            markup(colors.title, escape(title))
            --..markup(colors.time, escape(time)).." "
         )
      end
   )
end
helpers.newtimer("music", 1, M.update)
return M
