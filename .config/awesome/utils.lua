local awful = require("awful")
local naughty = require("naughty")


--local LOG_FILE = os.getenv("HOME").."/.log_awesome"
--awful.spawn.with_shell("echo 'START' > "..LOG_FILE)

-- Alias for string.format
sprintf = string.format
THIN_SPACE = "\xE2\x80\x85" --four per em space

function y_or_n(prompt, callback)
   awful.spawn.easy_async_with_shell("echo 'no\nyes' | rofi -dmenu -p '"..prompt.."'",
                                     function(stdout, _, _, _)
                                        callback(string.gsub(stdout, '%s+', '') == 'yes')
                                     end
   )
end

local home = os.getenv("HOME")

local function safe_bit_impl (what)
   awful.spawn({home.."/bin/safe_shutdown", "systemctl poweroff"})
end

function safe_shutdown ()
   safe_bit_impl("systemctl poweroff")
end
function safe_restart ()
   safe_bit_impl("systemctl reboot")
end

-- Log msg to log_file
function dlog(msg)
    naughty.notify({text=msg, timeout=50})
end
-- Log formated string to log_file
function dlogf(...)
   dlog(sprintf(...))
end

-- Run cmd if no instances are found
function run_once(cmd)
	space = cmd:find(" ")
	proc = cmd
--    dlogf("speis %s", space)
	if space then
		proc = proc:sub(0, space-1)
	end
	awful.spawn.with_shell(sprintf("pgrep -u $USER -x %s > /dev/null || (%s)", proc, cmd))
end

--dlog("OI!")

-- Get a function that spawns cmd
function exec(cmd)
	return function() awful.spawn(cmd) end
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- Get a function that spawns cmd with shell
function sh_exec(cmd)
	return function() awful.spawm.with_shell(cmd) end
end

-- Get a function that spawns cmd then calls callback
function exec_cb(cmd, callback)
	return function()
		awful.spawn(cmd)
		callback()
	end
end

-- Get a function that spawns cmd with shell then calls callback
function sh_exec_cb(cmd)
	return function()
		awful.spawm.with_shell(cmd)
		callback()
	end
end
function exec_term(term, cmd)
	return exec(sprintf("%s -title %s -e sh -c 'sh ~/.colors/shell; %s'",
	                    term, cmd, cmd))
end

-- Converts a string of type \d+\.\d* into
-- \d+:\d{2}
function sec_to_min_sec(sec)
	sec = math.floor(sec)
	return sprintf("%d:%02d", math.floor(sec / 60), sec % 60)
end
function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
end

function read_file(path)
	local file = io.open(path, "rb") -- r read mode and b binary mode
	if not file then return nil end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content:match("(.*)\n") or content
end

function trim(s)
	return s:match("^%s*(.-)%s*$")
end

function markup(color, text)
  return '<span foreground="#' .. color .. '">' .. text .. '</span>'
end

function clamp(val, min, max)
	if val < min then return min end
	if val > max then return max end
	return val
end
function clamp_check(val, min, max)
	if val <= min then return -1, min end
	if val >= max then return 1, max end
	return 0, val
end

function parse_color(color)
	if type(color) == "string" then
		local r, g, b, a = string.match(color.."FFFFFFFF", "#?(..)(..)(..)(..)")
		return {
			r = tonumber(r, 16) / 255,
			g = tonumber(g, 16) / 255,
			b = tonumber(b, 16) / 255,
			a = tonumber(a, 16) / 255,
		}
	elseif type(color) == "table" then
		return {
			r = color[1] or 0,
			g = color[2] or 0,
			b = color[3] or 0,
			a = color[4] or 1,
		}
	else
		error("invalid color, please use string or table")
	end
end

function split_string_lines(str)
   local res = {}
   local i = 1
   for line in str:gmatch("([^\n]*)\n?") do
      res[i] = line
      i = i + 1
      -- do something
   end
   return res
end
