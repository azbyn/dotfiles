local awful = require("awful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

local lain = require("lain")
local naughty = require("naughty")
local gears = require("gears")
local theme = require("theme")

local beautiful = require("beautiful")
local theme = require("theme")
--theme = beautiful.get()
--require("awful.hotkeys_popup.keys")

require("utils")
local M = {}

local mod   = "Mod4"
local hyper = "Mod3"
local alt   = "Mod1"
local ctrl  = "Control"
local shift = "Shift"

local term = {"Program", "Terminal (URXVT)",
    exec("urxvt")}

local browser1 = {"Program", "Browser - qutebrowser",
    exec_tag_special("W")}
local browser2 = {"Program", "Browser - firefox",
    exec("firefox")}
local launcher1 = {"Program", "Program Launcher",
    exec("rofi -modi drun -show drun")}
local launcher2  = {"Program", "Command Launcher",
    exec("rofi -modi run -show run")}--awful.screen.focused().mypromptbox:run()

local file_explorer = {"Program", "GUI - File Explorer - thunar",
        exec("thunar")}


local music = {
    next = {"Music", "Next Song", theme.music.next()},
    prev = {"Music", "Previous Song", theme.music.prev()},
    toggle = {"Music", "Play/Pause Music", theme.music.toggle()},
    pause = {"Music", "Pause Music", theme.music.pause()},
    fwd = {"Music", "Seek Forward", theme.music.fwd()},
    bfwd = {"Music", "Seek Forward Big", theme.music.bfwd()},
    bwd = {"Music", "Seek Backward", theme.music.bwd()},
    bbwd = {"Music", "Seek Backward Big", theme.music.bbwd()},
    beg = {"Music", "Seek Begining", theme.music.beg()},
}
local vol = {
    up = {"Volume", "Volume Up",
        theme.volume.call("amixer sset Master 10%+")},
    sup = {"Volume", "Volume Small Up",
        theme.volume.call("amixer sset Master 5%+")},
    down = {"Volume", "Volume Down",
        theme.volume.call("amixer sset Master 10%-")},
    sdown = {"Volume", "Volume Small Down",
        theme.volume.call("amixer sset Master 5%-")},
    mute = {"Volume", "Volume Mute",
        theme.volume.call("amixer sset Master toggle")},
}
local brightness = {
    up = {"Brightness", "Brightness Up",
          theme.brightness.exec("xbacklight + 10")}, --exec("light -A 10")},
    down = {"Brightness", "Brightness Down",
            theme.brightness.exec("xbacklight - 10")}, --exec("light -U 10")},
    low = {"Brightness", "Brightness Low",
          theme.brightness.exec("xbacklight = 2")}, --exec("light -S 20")},
    high = {"Brightness", "Brightness High",
          theme.brightness.exec("xbacklight = 100")}, --exec("light -S 100")},
}
local function set_titlebar(c, val)
    --if val then
    --    awful.titlebar(c, {size = theme.titlebar_height})
    --else
   awful.titlebar(c, {size = 0})
    --end
end

local last_layout
local is_maximized = false
local maximize = { "Client", "Maximize Window",
    function(c)
        if c.floating then
            c.maximized = not c.maximized
            if c.maximized then
                awful.placement.bottom(c)
            else
                awful.placement.centered(c)
            end
            c:raise()
            return
        end
        local layout = awful.layout.get(c.screen)
        local is_maximized = layout == awful.layout.suit.max
        --set_titlebar(c, is_maximized)
        if is_maximized then
            awful.layout.set(last_layout)
        else
            last_layout = layout
            awful.layout.set(awful.layout.suit.max)
        end
    end}
local fullscreen = {"Client", "Fullscreen",
    function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end}

local function switch_layout(i)
    if is_maximized then
        return
    end
    awful.layout.inc(i)
end

local function key(...)
    local mods = {...}
    local data = table.remove(mods) -- data:{group, description, press}
    local key = table.remove(mods)
    return awful.key(mods, key, data[3],
        {group=data[1], description=data[2]})
end
local function focus_direction(dir)
    awful.client.focus.bydirection(dir)
    if client.focus then client.focus:raise() end
end
local function toggle_dropdown(name)
    awful.screen.focused().dropdown[name]:toggle()
end
local function toggle_tag(name)
    local t = awful.tag.find_by_name(awful.screen.focused(), name)
    awful.tag.viewtoggle(t)
end
local function inc_width(c, factor)
    local s = c.screen
    local g = s:get_bounding_geometry()
    local inc = g.width * factor
    local clamped
    clamped, c.width = clamp_check(c.width + inc, math.abs(inc * 2), g.width)
    if clamped ~= -1 then
        c.x = clamp(c.x - (inc / 2), 0, g.width - c.width)
    end
end
local function inc_height(c, factor)
    local s = c.screen
    local g = s:get_bounding_geometry()
    local inc = g.height * factor
    local clamped
    clamped, c.height = clamp_check(c.height + inc, math.abs(inc * 2), g.height)

    if clamped ~= -1 then
        c.y = clamp(c.y - (inc / 2), 0, g.height - c.height)
    end
end
local function move_y(c, factor)
    local s = c.screen
    local g = s:get_bounding_geometry()
    local inc = g.height * factor
    c.y = clamp(c.y + inc, 0, g.height - c.height)
end
local function move_x(c, factor)
    local s = c.screen
    local g = s:get_bounding_geometry()
    local inc = g.width * factor
    c.x = clamp(c.x + inc, 0, g.width - c.width)
end
local function inc_tag(inc)
    local s = awful.screen.focused()
    local i = (tonumber(s.selected_tag.name) or 6) + inc
    if i < 1 then
        i = config.nr_normal_tags
    elseif i > config.nr_normal_tags then
        i = 1
    end

    awful.tag.viewnone(s)
    s.tags[i].selected = true
end
local home = os.getenv("HOME")

local mx_functions = {
   ["touch-toggle"] = theme.touch.toggle,
   ["meeting-mode-toggle"] = toggle_meeting_mode,
}

function M_x_menu()
   local str = "touch-toggle\nmeeting-mode-toggle"

   -- naughty.notify({text="strol '"..str.."'"})
   awful.spawn.easy_async_with_shell("echo '"..str.."' | rofi -dmenu -p 'awesome M-x' ",
                                     function(stdout, _, _, _)
                                        stdout = string.gsub(stdout, '%s+', '')
                                        if stdout ~= "" then
                                           local func = mx_functions[stdout]
                                           func()
                                        end
                                     end
   )
end

--[[local function switch_kb_layout()
    awful.spawn.easy_async({"setxkbmap", "-query"},
        function(out, _, _, _)
            local curr = string.match(out, "layout:%s*(.-)\n")
            dlogf("c = '%s', '%s'", curr,config.main_kb_layout[1] )

            local layout
            if curr == config.main_kb_layout[1] then
                dlog("in primary")
                layout = config.secondary_layout
                awful.spawn({"xset", "led", config.kb_led})
            else
                layout = config.main_kb_layout
                awful.spawn({"xset", "-led", config.kb_led})
            end
            local cmd = {"setxkbmap"}
            table.insert(cmd, layout[1])
            if layout[2] then
                table.insert(cmd, "-variant")
                table.insert(cmd, layout[2])
            end
            awful.spawn(cmd)
            awful.spawn({"xmodmap", home.."/.xmodmaprc"})
        end)
end
]]--

function define_keypad_key(k, val)
   return awful.key({hyper}, k, function ()
         naughty.notify({text="key "..k..":"..val})
         -- naughty.notify("
         awful.spawn("xdotool key '"..val.."'")
   end)
end

M.globalkeys = awful.util.table.join(
   key(mod, ctrl, "x", { "Misc", "M-x", M_x_menu}),
   key(mod, alt, "x", { "Misc", "M-x", M_x_menu}),

   -- define_keypad_key('bracketleft', 'KP_Divide'),
   -- define_keypad_key('bracketright', 'KP_Multiply'),

   -- define_keypad_key('8', '7'),
   -- define_keypad_key('9', '8'),
   -- define_keypad_key('0', '9'),

   -- define_keypad_key('i', '4'),
   -- define_keypad_key('o', '5'),
   -- define_keypad_key('p', '6'),

   -- define_keypad_key('k', '1'),
   -- define_keypad_key('l', '2'),
   -- define_keypad_key('semicolon', '3'),

   -- define_keypad_key('m', '0'),
   -- define_keypad_key('comma', '0'),
   -- define_keypad_key('period', 'KP_Decimal'),


   --emulated keypad with hyper

   -- key(translitKey, {"Misc", "quick transliteration",
                     -- function() translitKeygrabber:start() end}),
   -- key("Shift", translitKey, {"Misc", "quick transliteration",
                     -- function() translitKeygrabber:start() end}),
   -- key("Control_R", function()
   -- end),  --
    --awful.key({}, "Menu", exec("xdotool click 3")),
    --awful.key({shift}, "Menu", exec("xdotool click 1")),
    --awful.key({alt}, "Menu", exec("xdotool click 2")),
    --awful.key({ctrl}, "Menu", exec("xdotool click 3")),
    --key("Mod3", mod, "grave", {"Misc", "Caps Lock",
    --    exec("xdotool key Caps_Lock")}),
    --key(mod, "grave", term),
    --
  -- for the transition to new layout

   key(mod, "k", {"Misc", "Clear notifications - meeting mode",
                  function() toggle_meeting_mode() end}),

    -- key(hyper, "bracketleft", music["bwd"]),
    -- key(hyper, ctrl, "bracketleft", music["bbwd"]),
    -- key(hyper, "bracketright", music["fwd"]),
    -- key(hyper, ctrl, "bracketright", music["bfwd"]),

    --key(hyper, "equal", vol["up"]),
    --key(hyper, ctrl, "equal", vol["sup"]),
    --key(hyper, "minus", vol["down"]),
    --key(hyper, ctrl, "minus", vol["sdown"]),

    key(mod, "i", vol["up"]),
    key(mod, "j", vol["down"]),
    --key(mod, "i", music["next"]),
    --key(mod, "j", music["prev"]),

    -- key(hyper, "o", vol["up"]),
    -- key(hyper, "k", vol["down"]),
    --key(hyper, "i", {"misc", "send up",
    --                 function() awful.spawn({"xdotool", "key", "Up"}) end}),
    --key(hyper, "j", {"misc", "send down",
    --                 function() awful.spawn({"xdotool", "key", "Down"}) end}),
    --key(hyper, "i", music["next"]),
    --key(hyper, "j", music["prev"]),
    -- key(hyper, "r", {"Misc", "Small Dropdown Terminal",
                     -- function() toggle_dropdown("small") end}),

  -- key(hyper, "e", {"Program", "Emacs",
  --                exec_tag_special("E")}),
  -- key(hyper, "w", {"Misc", "Emacs Dropdown Terminal",
  --                  function() toggle_dropdown("emacs") end}),

  --key(hyper, "t", {"Misc", "Emacs Dropdown Terminal",
  --                 function() toggle_dropdown("emacs") end}),

    --key(hyper, "p", music["toggle"]),


    --key(hyper, "", vol["down"]),
    --key(hyper, "o", vol["up"]),
  -- key(hyper, "m", {"Misc", "Dropdown music player",
  --                function() toggle_dropdown("music") end}),

    --key(alt, "minus", vol["down"]),
  --key(hyper, "k", {"Misc", "switch alt",
   --                function()
    --                 awful.spawn.with_shell({"/home/azbyn/.local/bin/switchalt"})
  --end}),
    key(alt, ctrl, "minus", vol["sdown"]),



    -- key(alt, "apostrophe", vol["up"]),
    -- key(alt, ctrl, "apostrophe", vol["sup"]),
    -- key(alt, "semicolon", vol["down"]),
    -- key(alt, ctrl, "semicolon", vol["sdown"]),

    key(alt, "Left", {"Movement", "Focus Left",
        function() focus_direction("left") end}),
    key(alt, "Right", {"Movement", "Focus Right",
        function() focus_direction("right") end}),


    -- key(alt, "grave", theme.mymainmenu:show()),
    key(mod, ctrl, "Return", {"Misc", "emacs window",
        exec("emacsclient -c -n -e")}),

    key(mod, "w", {"Misc", "emacs window",
        function() toggle_dropdown("emacs") end}),
    key(mod, "f", {"Misc", "signal window",
                   function()
                      exec_tag_special("s")
                      -- toggle_dropdown("signal")
    end}),

    key(mod, ctrl, "p", {"misc", "Sstfy Print screen",
        function()
            awful.spawn(home.. "/bin/sstfy")
        end}),
    key(mod, alt, "p", {"misc", "Print screen",
        function()
            awful.spawn("scrot -e 'mv $f ~/Pictures/screenshots 2>/dev/null'")
            naughty.notify({text="took screenshot"})
        end}),

    key(mod, ctrl, "v", {"Misc", "Use mrww from",
        exec("mrww from")}),
    key(mod, ctrl, "c", {"Misc", "Use mrww to",
        exec("mrww to")}),
    key(mod, ctrl, "x", {"Misc", "Use mrww torofi",
        exec("mrww torofi")}),

    key(mod, "r", {"Misc", "Transliterate",
        function() toggle_dropdown("transliterate") end}),

    -- key(hyper, "l", {"Misc", "LaTeX",
    --     function() toggle_dropdown("latex") end}),


    --awful.key({mod, shift}, "Menu", function() switch_kb_layout() end),
    key(mod, "F1", {"Misc", "Show Help",
        hotkeys_popup.show_help}),

    key(mod, "BackSpace", {"Misc", "Clear notifications",
                           function() naughty.destroy_all_notifications() end}),


    key(mod, ctrl, "BackSpace", {"Misc", "Restart Awesome",
        awesome.restart}),

    key(hyper, ctrl, "BackSpace", {"Misc", "Restart Awesome",
        awesome.restart}),
    key(mod, ctrl, "r", {"Misc", "Restart Awesome",
        awesome.restart}),
    key(shift, hyper, alt, "BackSpace", {"Misc", "Restart", safe_restart}),
    key(mod, ctrl, "Escape", {"Misc", "Quit Awesome",
        function() awesome.quit() end}),
    key(shift, hyper, alt, "Escape", {"Misc", "Shutdown", safe_shutdown}),


    --[[key(alt, "Tab", {"Movement", "View Last Window",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end}),
    --]]--
    key(mod, "space", {"Movement", "Last Tags",
        awful.tag.history.restore}),

    key(alt, "tab", {"Layout", "Select next layout",
        function()
            switch_layout(1)
            --naughty.notify({text="OIDA"})
            --gears.wallpaper.maximized(os.getenv("HOME").. "/Pictures/bear.jpg",
            --    awful.screen.focused(), true)
        end}),

    --key(mod, "h", {"Movement", "Previous Tag",
    --    function() inc_tag(-1) end}),--awful.tag.viewprev}),
    --key(mod, "l", {"Movement", "Next Tag",
    --    function() inc_tag(1) end}),--awful.tag.viewnext}),
    key(mod, "o", {"Movement", "Next Window",
        function() awful.client.focus.byidx(1) end}),
    key(mod, shift, "o", {"Movement", "Previous Window",
        function() awful.client.focus.byidx(-1) end}),

    key(mod, "Left", {"Movement", "Focus Left",
        function() focus_direction("left") end}),
    key(mod, "Right", {"Movement", "Focus Right",
        function() focus_direction("right") end}),
    key(mod, "Up", {"Movement", "Focus Up",
        function() focus_direction("up") end}),
    key(mod, "Down", {"Movement", "Focus Down",
        function() focus_direction("down") end}),

    key(mod, ctrl, shift, "Left", {"Layout", "Increase Number of Master Clients",
        function() awful.tag.incnmaster(1, nil, true) end}),
    key(mod, ctrl, shift, "Right", {"Layout", "Decrease Number of Master Clients",
        function() awful.tag.incnmaster(-1, nil, true) end}),
    key(mod, ctrl, shift, "Up", {"Layout", "Increase Number of columns",
        function() awful.tag.incncol(1, nil, true) end}),
    key(mod, ctrl, shift, "Down", {"Layout", "Decrease Number of columns",
        function() awful.tag.incncol(-1, nil, true) end}),


    key(mod, ctrl, shift, "h", {"Layout", "Increase Number of Master Clients",
        function() awful.tag.incnmaster(1, nil, true) end}),
    key(mod, ctrl, shift, "l", {"Layout", "Decrease Number of Master Clients",
        function() awful.tag.incnmaster(-1, nil, true) end}),
    key(mod, ctrl, shift, "k", {"Layout", "Increase Number of columns",
        function() awful.tag.incncol(1, nil, true) end}),
    --key(mod, ctrl, shift, "j", {"Layout", "Decrease Number of columns",
    --    function() awful.tag.incncol(-1, nil, true) end}),


    key(mod, "b", {"Screen", "Focus Previous Screen",
        function() awful.screen.focus_relative(-1) end}),
    key(mod, "n", {"Screen", "Focus Next Screen",
        function() awful.screen.focus_relative(1) end}),

    key("XF86AudioPlay", music["toggle"]),
    key("XF86AudioNext", music["next"]),
    key("XF86AudioPrev", music["prev"]),
    key("XF86AudioRaiseVolume", vol["up"]),
    key("XF86AudioLowerVolume", vol["down"]),
    key("XF86AudioMute", vol["mute"]),
    --key("XF86MonBrightnessUp", brightness["up"]),
    --key("XF86MonBrightnessDown", brightness["down"]),

    --key(mod, "Insert", music["prev"]),
    --key(mod, shift, "Insert", music["beg"]),
    --key(mod, "Home", music["next"]),

    --key(mod, "Delete", music["bwd"]),
    --key(mod, shift, "Delete", music["bbwd"]),
    --key(mod, "End", music["fwd"]),
    --key(mod, shift, "End", music["bfwd"]),

    --key(mod, "Print", music["toggle"]),
    --key(mod, shift, "Print", music["pause"]),
    --key(mod, "Pause", vol["mute"]),
    --key(mod, "Scroll_Lock", {"Misc", "Dropdown music player",
    --    function() toggle_dropdown("music") end}),


    -- key(mod, "Prior", vol["up"]),
    -- key(mod, shift, "Prior", vol["sup"]),
    -- key(mod, "Next", vol["down"]),
    -- key(mod, shift, "Next", vol["sdown"]),

    key(mod, "bracketleft", music["bwd"]),
    key(mod, ctrl, "bracketleft", music["bbwd"]),
    key(mod, "bracketright", music["fwd"]),
    key(mod, ctrl, "bracketright", music["bfwd"]),

    key(mod, "equal", vol["up"]),
    key(mod, ctrl, "equal", vol["sup"]),
    key(mod, "minus", vol["down"]),
    key(mod, ctrl, "minus", vol["sdown"]),

    key(mod, "apostrophe", vol["up"]),
    key(mod, ctrl, "apostrophe", vol["sup"]),
    key(mod, "semicolon", vol["down"]),
    key(mod, ctrl, "semicolon", vol["sdown"]),


    key(mod, "p", music["toggle"]),
    key(mod, ctrl, "m", vol["mute"]),
    key(mod, ctrl, "z", music["beg"]),
    key(mod, "z", music["prev"]),
    key(mod, "x", music["next"]),


    key(mod, "period", brightness["up"]),
    key(mod, ctrl, "period", brightness["high"]),
    key(mod, "comma", brightness["down"]),
    key(mod, ctrl, "comma", brightness["low"]),

    key(mod, shift, "period", brightness["high"]),
    key(mod, shift, "comma", brightness["low"]),


    key(mod, "Return", term),

    key(mod, "u", {"Movement", "Jump to urgent client",
        awful.client.urgent.jumpto}),

    --key(mod, "w", browser1),
    key(mod, alt, "w", {"Tag", "Toggle tag W",
        function() toggle_tag("W") end}),
    key(mod, ctrl, "w", browser2),

    key(mod, "d", launcher1),
    key(mod, ctrl, "d", launcher2),

    --key(mod, "i", {"Program", "Htop",
    --    exec_term(config.term, "htop")}),

    key(hyper, ctrl, "p", {"Program", "KeePassXC",
        exec_tag_special("P")}),
    --key(mod, alt, "p", {"Tag", "Toggle tag P",
    --    function() toggle_tag("P") end}),


    key(mod, "g", {"Program", "Gimp",
        exec_tag_special("G")}),
    key(mod, alt, "g", {"Tag", "Toggle tag G",
        function() toggle_tag("G") end}),

    key(mod, ctrl, "t", {"Program", "qBittorrent",
        exec_tag_special("T")}),
    key(mod, alt, "t", {"Tag", "Toggle tag T",
        function() toggle_tag("T") end}),

    key(mod, "e", {"Program", "Emacs",
        exec_tag_special("E")}),
    key(mod, alt, "e", {"Tag", "Toggle tag E",
        function() toggle_tag("E") end}),

    --[[key(mod, "v", {"Program", "Vlc",
        exec_tag_special("V")}),
    key(mod, ctrl, "v", {"Tag", "Toggle tag V",
        function() toggle_tag("V") end}),]]--

    key(mod, ctrl, "s", {"Program", "Android Studio",
        exec_tag_special("S")}),

    key(mod, "a", {"Misc", "Big Dropdown Terminal",
        function() toggle_dropdown("big") end}),
    key(mod, "s", {"Misc", " Small Dropdown Terminal",
        function() toggle_dropdown("small") end}),

    -- key(mod, "t", {"Misc", "Edit Todo",
        -- function() toggle_dropdown("todo") end}),

    key(mod, "m", {"Misc", "Dropdown music player",
        function() toggle_dropdown("music") end}),

    --key(mod, ctrl, "b", {"Widgets", "Show Battery Widget",
    --    function() theme.battery.show(5) end}),
    --key(mod, ctrl, "n", {"Widgets", "Show Network Widget",
    --    function() theme.net.show(5) end}),
    --key(mod, ctrl, "c", {"Widgets", "Show Calendar Widget",
    --    function() lain.widget.calendar.show(5) end}),


        -- key(mod, ctrl, "equal", {"Misc", "Increment gaps",
        --                          function() lain.util.useless_gaps_resize(1) end}),
        -- key(mod, ctrl, "minus", {"Misc", "Decrement gaps",
        --                         function() lain.util.useless_gaps_resize(-1) end}),

    key(mod, alt, "e", {"Misc", "Emacs toggle",
        function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[7]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end }),
    key(mod, ctrl, "e", {"Misc", "Emacs move",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[7]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end}),
    key(mod, alt, ctrl, "e", {"Misc", "Emacs toggle_focus",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[7]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end})
    --key(mod, shift, "f", file_explorer)
    --key(mod, alt}, "n", {"Test - Client", "Minimize",
    --    function(c) c.minimized = true end}),
)

local decrease_width = {"Layout", "Decrease Master/Floating Width",
                        function(c)
                           if c.floating then
                              inc_width(c, -0.05)
                           else
                              awful.tag.incmwfact(-0.05)
                           end
                        end
}
local increase_width = {"Layout", "Increase Master/Floating Width",
                        function(c)
                           if c.floating then
                              inc_width(c, 0.05)
                           else
                              awful.tag.incmwfact(0.05)
                           end
                        end
}


M.clientkeys = awful.util.table.join(
    key(mod, ctrl, "Left", {"Movement", "Swap Left / Floating Move Left",
        function(c)
            if c.floating then
                move_x(c, -0.025)
            else
                awful.client.swap.global_bydirection("left")
            end
        end}),
    key(mod, ctrl, "Right", {"Movement", "Swap Right / Floating Move Right",
        function(c)
            if c.floating then
                move_x(c, 0.025)
            else
                awful.client.swap.global_bydirection("right")
            end
        end}),
    key(mod, ctrl, "Up", {"Movement", "Swap Up / Floating Move Up",
        function(c)
            if c.floating then
                move_y(c, -0.025)
            else
                awful.client.swap.global_bydirection("up")
            end
        end}),
    key(mod, ctrl, "Down", {"Movement", "Swap Down / Floating Move Down",
        function(c)
            if c.floating then
                move_y(c, 0.025)
            else
                awful.client.swap.global_bydirection("down")
            end
        end}),

    key(mod, ctrl, "h", {"Layout", "Floating Move Left",
        function(c)
            if c.floating then
                move_x(c, -0.025)
            end
        end}),
    --key(mod, ctrl, "l", {"Layout", "Floating Move Right",
    --    function(c)
    --        if c.floating then
    --            move_x(c, 0.025)
    --        end
    --    end}),
    --key(mod, ctrl, "j", {"Layout", "Swap with next client by index / Floating Move Down",
    --    function(c)
    --        if c.floating then
    --            move_y(c, 0.025)
    --        else
    --            awful.client.swap.byidx(1)
    --        end
    --    end}),
    --key(mod, ctrl, "k", {"Layout", "Swap with next client by index / Floating Move Up",
    --    function(c)
    --        if c.floating then
    --            move_y(c, -0.025)
    --        else
    --            awful.client.swap.byidx(-1)
    --        end
    --    end}),


    key(mod, ctrl, "Home", decrease_width),
    key(mod, ctrl, "End", increase_width),
    key(mod, alt, "Home", decrease_width),
    key(mod, alt, "End", increase_width),

    key(mod, alt, "Left", decrease_width),
    key(mod, alt, "Right", increase_width),
    key(mod, alt, "Up", {"Layout", "Increase Client/Floating Height",
        function(c)
            if c.floating then
                inc_height(c, 0.05)
            else
                awful.client.incwfact(0.05)
            end
        end}),
    key(mod, alt, "Down", {"Layout", "Decrease Client/Floating Height",
        function(c)
            if c.floating then
                inc_height(c, -0.05)
            else
                awful.client.incwfact(-0.05)
            end
        end}),

    --key(mod, alt, "h", {"Layout", "Decrease Master/Floating Width",
    --    function(c)
    --        if c.floating then
    --            inc_width(c, -0.05)
    --        else
    --            awful.tag.incmwfact(-0.05)
    --        end
    --    end}),
    --key(mod, alt, "l", {"Layout", "Increase Master/Floating Width",
    --    function(c)
    --        if c.floating then
    --            inc_width(c, 0.05)
    --        else
    --            awful.tag.incmwfact(0.05)
    --        end
    --    end}),
    --key(mod, alt, "k", {"Layout", "Increase Client/Floating Height",
    --    function(c)
    --        if c.floating then
    --            inc_height(c, 0.05)
    --        else
    --            awful.client.incwfact(0.05)
    --        end
    --    end}),
    --key(mod, alt, "j", {"Layout", "Decrease Client/Floating Height",
    --    function(c)
    --        if c.floating then
    --            inc_height(c, -0.05)
    --        else
    --            awful.client.incwfact(-0.05)
    --        end
    --    end}),

    key(mod, "F11", maximize),
    key(mod, ctrl, "F11", fullscreen),
    key(mod, ctrl, "space", {"Client", "Toggle floating",
        function(c) lain.util.magnify_client(c); c:raise() end }),

    key(mod, alt, "f", maximize),
    key(mod, ctrl, "f", fullscreen),

    -- key(hyper, "f", maximize),
    key(hyper, alt, "f", maximize),
    key(hyper, ctrl, "f", fullscreen),

    key(mod, "q", {"Client", "Close",
        function(c) c:kill() end}),
    key(mod, ctrl, "q", {"Client", "Kill", -- used in extreme cases
        function(c)
            awful.spawn.with_shell("xkill -id `xprop -root _NET_ACTIVE_WINDOW | cut -d\\# -f2`")
        end}),

    key(mod, "grave", {"Client", "Move to master",
        function(c) c:swap(awful.client.getmaster()) end}),
    key(mod, ctrl, "o", {"Client", "Move to screen",
        function(c) c:move_to_screen() end}),
    key(mod, ctrl, "a", {"Client", "Toggle keep on top",
        function(c) c.ontop = not c.ontop end})
)

for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "View Tag #", group = "Tag"}
        descr_toggle = {description = "Toggle tag #", group = "Tag"}
        descr_move = {description = "Move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
    end
    M.globalkeys = awful.util.table.join(M.globalkeys,

        -- awful.key({hyper}, "#" .. i + 9,
        --         function ()
        --             local screen = awful.screen.focused()
        --             local tag = screen.tags[i]
        --             if tag then
        --                 tag:view_only()
        --                 --[[if screen.clients[1] then
        --                     screen.clients[1]:raise()
        --                 end]]
        --             end
        --         end,
        --         descr_view),
        -- -- Toggle tag display.
        -- awful.key({hyper, alt}, "#" .. i + 9,
        --         function ()
        --             local screen = awful.screen.focused()
        --             local tag = screen.tags[i]
        --             if tag then
        --                 awful.tag.viewtoggle(tag)
        --             end
        --         end,
        --         descr_toggle),
        -- -- Move client to tag.
        -- awful.key({hyper, ctrl}, "#" .. i + 9,
        --         function ()
        --             if client.focus then
        --                 local tag = client.focus.screen.tags[i]
        --                 if tag then
        --                     client.focus:move_to_tag(tag)
        --                     tag:view_only()
        --                 end
        --             end
        --         end,
        --         descr_move),
        -- -- Toggle tag on focused client.
        -- awful.key({hyper, alt, ctrl}, "#" .. i + 9,
        --         function ()
        --             if client.focus then
        --                 local tag = client.focus.screen.tags[i]
        --                 if tag then
        --                     client.focus:toggle_tag(tag)
        --                 end
        --             end
        --         end,
        --         descr_toggle_focus),
                                       ---REEEEEEEEEEEEEe
        -- View tag only.
        awful.key({mod}, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                        --[[if screen.clients[1] then
                            screen.clients[1]:raise()
                        end]]
                    end
                end,
                descr_view),
        -- Toggle tag display.
        awful.key({mod, alt}, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                descr_toggle),
        -- Move client to tag.
        awful.key({mod, ctrl}, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                            tag:view_only()
                        end
                    end
                end,
                descr_move),
        -- Toggle tag on focused client.
        awful.key({mod, alt, ctrl}, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                descr_toggle_focus)
    )
end

return M
