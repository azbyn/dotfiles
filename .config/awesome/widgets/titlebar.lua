local abutton = require("awful.button")
local aclient = require("awful.client")
local atooltip = require("awful.tooltip")
local imagebox = require("widgets.imagebox")
local config = require("config")

local M = {}
M.enable_tooltip = false
M.icons = {
	close = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/close.png",
			[true]  = config.colors.orange,--focused
			[false] = config.colors.base02,--normal
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/close.png",
			[true]  = config.colors.orange,--focused
			[false] = config.colors.base02,--normal
		},
	},
	ontop = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/on-top.png",
			[true]  = config.colors.orange,
			[false] = config.colors.base02,
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/on-top.png",
			[true]  = config.colors.base03,
			[false] = config.colors.base02,
		},
	},
	sticky = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/sticky.png",
			[true]  = config.colors.orange,
			[false] = config.colors.base02,
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/sticky.png",
			[true]  = config.colors.base03,
			[false] = config.colors.base02,
		},
	},
	minimize = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/minimize.png",
			[true]  = config.colors.base03,
			[false] = config.colors.base02,
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/minimize.png",
			[true]  = config.colors.base03,
			[false] = config.colors.base02,
		},
	},

	maximized = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/restore.png",--"window_nofullscreen.png",
			[true]  = config.colors.orange,
			[false] = config.colors.base02,
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/maximize.png",--"window_fullscreen.png",
			[true]  = config.colors.base03,
			[false] = config.colors.base02,
		},
	},
	floating = {
		[true] = {-- active
			icon    = config.icons_dir.."titlebar/floating-active.png",--"window.png",
			[true]  = config.colors.orange,
			[false] = config.colors.base02,
		},
		[false] = {--inactive
			icon    = config.icons_dir.."titlebar/floating-inactive.png",--"window-duplicate.png",
			[true]  = config.colors.base03,--focused
			[false] = config.colors.base02,
		},
	}
}


function M.button(c, name, get_state, action)
	local ret = imagebox()
	if M.enable_tooltip  then
		ret._private.tooltip = atooltip({ objects = {ret}, delay_show = 1 })
		ret._private.tooltip:set_text(name)
	end

	local function update()
		local data = M.icons[name][get_state(c)]
		local color = data[client.focus == c]
		ret:set_image(data.icon, color)
	end
	ret.state = ""
	if action then
		ret:buttons(abutton({ }, 1, nil, function()
			ret.state = ""
			update()
			action(c, get_state(c))
		end))
	else
		ret:buttons(abutton({ }, 1, nil, function()
			ret.state = ""
			update()
		end))
	end
	ret:connect_signal("mouse::enter", function()
		ret.state = "hover"
		update()
	end)
	ret:connect_signal("mouse::leave", function()
		ret.state = ""
		update()
	end)
	ret:connect_signal("button::press", function(_, _, _, b)
		if b == 1 then
			ret.state = "press"
			update()
		end
	end)
	ret.update = update
	update()

	-- We do magic based on whether a client is focused above, so we need to
	-- connect to the corresponding signal here.
	c:connect_signal("focus", update)
	c:connect_signal("unfocus", update)

	return ret
end

function M.floatingbutton(c)
    local widget = M.button(c, "floating", aclient.object.get_floating, aclient.floating.toggle)
    c:connect_signal("property::floating", widget.update)
    return widget
end

function M.maximizedbutton(c)
    local widget = M.button(c, "maximized", function(cl)
        return cl.maximized
    end, function(cl, state)
        cl.maximized = not state
    end)
    c:connect_signal("property::maximized", widget.update)
    return widget
end


function M.minimizebutton(c)
    local widget = M.button(c, "minimize",
                            function() return false end,
                            function(cl) cl.minimized = not cl.minimized end)
    c:connect_signal("property::minimized", widget.update)
    return widget
end

function M.closebutton(c)
    return M.button(c, "close", function() return false end, function(cl) cl:kill() end)
end

function M.ontopbutton(c)
    local widget = M.button(c, "ontop",
                            function(cl) return cl.ontop end,
                            function(cl, state) cl.ontop = not state end)
    c:connect_signal("property::ontop", widget.update)
    return widget
end

function M.stickybutton(c)
    local widget = M.button(c, "sticky",
                            function(cl) return cl.sticky end,
                            function(cl, state) cl.sticky = not state end)
    c:connect_signal("property::sticky", widget.update)
    return widget
end

return M
