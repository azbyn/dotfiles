local awful    = require("awful")
local wibox    = require("wibox")
local helpers  = require("lain.helpers")
local config   = require("config")
--local imagebox = require("widgets.imagebox")
local naughty  = require("naughty")

local imagebox_multi = require("widgets/imagebox_multi")
require("utils")

local WIFI_00  = config.icons_dir.."wifi-00.png"
local WIFI_25  = config.icons_dir.."wifi-25.png"
local WIFI_50  = config.icons_dir.."wifi-50.png"
local WIFI_75  = config.icons_dir.."wifi-75.png"
local WIFI_100 = config.icons_dir.."wifi-100.png"
local WIFI_NO  = config.icons_dir.."wifi-no.png"
local WIRED    = config.icons_dir.."wired.png"
local WIRED_NO = config.icons_dir.."wired-no.png"
local NONE     = config.icons_dir.."no-connection.png"

local IDLE = config.icons_dir.."net-idle.png"
local RX   = config.icons_dir.."net-rx.png"
local TX   = config.icons_dir.."net-tx.png"
local RXTX = config.icons_dir.."net-rxtx.png"

local WIFI_DEV  = "wlp3s0"
local WIRED_DEV = "enp2s0"

local UNIT        = 1024 -- KB
local UPDATE_RATE = 2
local BIG_UPDATE_RATE = 60
local TRESHOLD    = 0


local M = { last = { t = 0, r = 0, sent = 0, received = 0, up = true }, name = "NONE" }
M.widget = imagebox_multi(
	{WIFI_100, IDLE},
	{config.colors.fg_normal, config.colors.black}
)

function M.show(timeout)
	M.update()
	M.hide()
	M.notification = naughty.notify({
		bg          = "#"..config.colors.bg_light,
		fg          = "#"..config.colors.fg_focus,
		font        = "DejaVu Sans Mono 10",
		timeout     = timeout or 5,
		title       = M.name,
		text        = sprintf("%.1f %.1f", M.last.sent, M.last.received),
	})
end
function M.hide()
	if not M.notification then return end
	naughty.destroy(M.notification)
	M.notification = nil
end

M.widget:connect_signal('mouse::enter', function() M.show(0) end)
M.widget:connect_signal('mouse::leave', function() M.hide() end)

function M.update_big()--update name and signal quality
	if M.dev == WIFI_DEV then
		if M.up then
			M.name = "Not connected"
			M.icon = WIFI_NO
			return
		end
		awful.spawn.easy_async({"iwconfig", wifi_dev},
			function(out, _, _, _)
				local ssid, quality, max = string.match(out,
					'.*SSID:"(.-)".*Link Quality=(%d+)/(%d+).*')
				if not ssid then
					M.name = "Not connected"
					M.icon = WIFI_NO
					return
				end
				M.quality = tonumber(quality) / tonumber(max)
				M.name = ssid
				if M.quality >= 0.95 then
					M.icon = WIFI_100
				elseif M.quality >= 0.70 then
					M.icon = WIFI_75
				elseif M.quality >= 0.45 then
					M.icon = WIFI_50
				elseif M.quality >= 0.20 then
					M.icon = WIFI_25
				else
					M.icon = WIFI_00
				end
			end)
	elseif M.dev == WIRED_DEV then
		if M.up then
			M.name = "Ethernet"
			M.icon = WIRED
		else
			M.name = "Not connected"
			M.icon = WIRED_NO
		end
	else
		M.name = "No Connection"
		M.icon = NONE
	end

end
function M.update()
	if read_file("/sys/class/net/"..WIFI_DEV.."/operstate") == "up" then
		M.dev = WIFI_DEV
	elseif read_file("/sys/class/net/"..WIRED_DEV.."/operstate") == "up" then
		M.dev = WIRED_DEV
	end
	local now = {}

	if M.dev then
		local dir = "/sys/class/net/"..M.dev
		now.t        = tonumber(read_file(dir.."/statistics/tx_bytes") or 0)
		now.r        = tonumber(read_file(dir.."/statistics/rx_bytes") or 0)
		now.up       = read_file(dir.."/carrier") == "1"
		now.sent     = (now.t - M.last.t) / UPDATE_RATE / UNIT
		now.received = (now.r - M.last.r) / UPDATE_RATE / UNIT
	else
		now = {t = 0, r = 0, sent = 0, received = 0, up = false}
	end
	local state_icon = now.sent > TRESHOLD and
		(now.received > TRESHOLD and RXTX or TX) or
		(now.received > TRESHOLD and RX or IDLE)
	M.widget:set_images({M.icon, state_icon}, {config.colors.fg_normal, config.colors.black})

	if not now.up and M.last.up then
		M.update_big()
		M.id = naughty.notify({
			title       = "No internet",
			text        = "You might want to restart your router",
			timeout     = 5,
			replaces_id = M.id,
			bg          = "#"..config.colors.bg_light,
			fg          = "#"..config.colors.red,
			icon        = helpers.icons_dir .. "no_net.png",
			font        = "DejaVu Sans Mono 14",
		}).id
	end
	
	M.last = now
end
M.update()--get a baseline for rx and tx
M.update_big()
helpers.newtimer("net_", UPDATE_RATE, M.update)
helpers.newtimer("net_big", BIG_UPDATE_RATE, M.update_big)

return M

