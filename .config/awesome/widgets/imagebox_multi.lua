---------------------------------------------------------------------------
--
--@DOC_wibox_widget_defaults_imagebox_EXAMPLE@
-- @author Uli Schlachter
-- @copyright 2010 Uli Schlachter
-- @classmod wibox.widget.imagebox
---------------------------------------------------------------------------

local base = require("wibox.widget.base")
local surface = require("gears.surface")
local gtable = require("gears.table")
local setmetatable = setmetatable
local type = type
local print = print
local unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)

local imagebox = { mt = {} }

-- Draw an imagebox with the given cairo context in the given geometry.
function imagebox:draw(_, cr, width, height)
    if not self._private.images then return end
    if width == 0 or height == 0 then return end

    if not self._private.resize_forbidden then
        -- Let's scale the image so that it fits into (width, height)
        local w = self._private.images[1]:get_width()
        local h = self._private.images[1]:get_height()
        local aspect = width / w
        local aspect_h = height / h
        if aspect > aspect_h then aspect = aspect_h end

        cr:scale(aspect, aspect)
    end

    -- Set the clip
    if self._private.clip_shape then
        cr:clip(self._private.clip_shape(cr, width, height, unpack(self._private.clip_args)))
    end

    local pat = require("lgi").cairo.Pattern
    for i, img in ipairs(self._private.images) do
        local col = self._private.colors[i]
        cr:set_source_rgba(col.r, col.g, col.b, col.a)
        
        cr:mask(pat.create_for_surface(img), 0, 0)
    end
end

-- Fit the imagebox into the given geometry
function imagebox:fit(_, width, height)
    if not self._private.images[1] then
        return 0, 0
    end

    local w = self._private.images[1]:get_width()
    local h = self._private.images[1]:get_height()

    if w > width then
        h = h * width / w
        w = width
    end
    if h > height then
        w = w * height / h
        h = height
    end

    if h == 0 or w == 0 then
        return 0, 0
    end

    if not self._private.resize_forbidden then
        local aspect = width / w
        local aspect_h = height / h

        -- Use the smaller one of the two aspect ratios.
        if aspect > aspect_h then aspect = aspect_h end

        w, h = w * aspect, h * aspect
    end
    return w, h
end

--- Set an imagebox' image
-- @property image
-- @param image Either a string or a cairo image surface. A string is
--   interpreted as the path to a png image file.
-- @return true on success, false if the image cannot be used
function imagebox:set_image_at(i, imag, col)
    if type(img) == "string" then
    img = surface.load(img)
        if not img then
            print(debug.traceback())
            return false
        end
    end
    img = img and surface.load(img)
    if img then
        if img.width <= 0 or img.height <= 0 then
            return false
        end
    end
    self._private.images[i] = img

    self._private.colors[i] = col and parse_color(col) or {r=1,g=1,b=1,a=1}
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("widget::layout_changed")
    return true
end

function imagebox:set_images(images, colors)
    self._private.images = {}
    for i, img in ipairs(images) do
        if type(img) == "string" then
        img = surface.load(img)
            if not img then
                print(debug.traceback())
                return false
            end
        end
        img = img and surface.load(img)
        if img then
            if img.width <= 0 or img.height <= 0 then
                return false
            end
        end
        self._private.images[i] = img
    end
    self._private.colors = {}
    if colors then
        for i, col in ipairs(colors) do
            self._private.colors[i] = parse_color(col)
        end
    else
        for i=1,#images do
            self._private.colors[i] = {r=1,g=1,b=1,a=1}
        end
    end
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("widget::layout_changed")
    return true
end

--- Set a clip shape for this imagebox
-- A clip shape define an area where the content is displayed and one where it
-- is trimmed.
--
-- @property clip_shape
-- @param clip_shape A `gears_shape` compatible shape function
-- @see gears.shape
-- @see set_clip_shape

--- Set a clip shape for this imagebox
-- A clip shape define an area where the content is displayed and one where it
-- is trimmed.
--
-- Any other parameters will be passed to the clip shape function
--
-- @param clip_shape A `gears_shape` compatible shape function
-- @see gears.shape
-- @see clip_shape
function imagebox:set_clip_shape(clip_shape, ...)
    self._private.clip_shape = clip_shape
    self._private.clip_args = {...}
    self:emit_signal("widget::redraw_needed")
end

--- Should the image be resized to fit into the available space?
-- @property resize
-- @param allowed If false, the image will be clipped, else it will be resized
--   to fit into the available space.

function imagebox:set_resize(allowed)
    self._private.resize_forbidden = not allowed
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("widget::layout_changed")
end

--- Returns a new imagebox.
-- Any other arguments will be passed to the clip shape function
-- @param image the image to display, may be nil
-- @param resize_allowed If false, the image will be clipped, else it will be resized
--   to fit into the available space.
-- @param clip_shape A `gears.shape` compatible function
-- @treturn table A new `imagebox`
-- @function wibox.widget.imagebox
local function new(images, colors, resize_allowed, clip_shape)
    local ret = base.make_widget(nil, nil, {enable_properties = true})

    gtable.crush(ret, imagebox, true)

    if images then
        ret:set_images(images, colors)
    end
    if resize_allowed ~= nil then
        ret:set_resize(resize_allowed)
    end

    ret._private.clip_shape = clip_shape
    ret._private.clip_args = {}

    return ret
end

function imagebox.mt:__call(...)
    return new(...)
end

--@DOC_widget_COMMON@

--@DOC_object_COMMON@

return setmetatable(imagebox, imagebox.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
