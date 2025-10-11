--- @module "fi.dea.ccLib.monitor"
--- @class fi.dea.ccLib.monitor

local exports = {}

--- @class fi.dea.ccLib.monitor.MonitorEx
--- @field monitor ccTweaked.peripherals.Monitor
--- @field size vec2
local MonitorEx = {}
MonitorEx.__index = MonitorEx;

--- Resets the monitor to default configuration
function MonitorEx:reset()
    self.monitor.setTextColor(colors.white)
    self.monitor.setBackgroundColor(colors.black)
    self.monitor.clear()
    self.monitor.setCursorPos(1,1)
    self.monitor.setTextScale(1)
end

--- Draw colored text at the given position
--- @param pos vec2 | nil
--- @param text string
--- @param textColor ccTweaked.colors.color
--- @param bgColor ccTweaked.colors.color
function MonitorEx:drawText(pos, text, textColor, bgColor)
    self.monitor.setTextColor(textColor)
    self.monitor.setBackgroundColor(bgColor)
    self:setPos(pos)
    self.monitor.write(text)
end

--- Draw colored centered text at the given position
--- @param pos vec2 | nil
--- @param text string
--- @param size number The length of the bar in characters
--- @param textColor ccTweaked.colors.color
--- @param bgColor ccTweaked.colors.color
function MonitorEx:drawCenteredText(pos, text, size, textColor, bgColor)
    local padding = size - text:len()
    local u = math.floor(padding / 2)
    local v = padding - u

    self:setPos(pos)
    self:drawEmptyGauge(nil, u, bgColor)
    self:drawText(nil, text, textColor, bgColor)
    self:drawEmptyGauge(nil, v, bgColor)
end

--- Set the cursor position
--- Does nothing if pos is nil
--- @param pos vec2 | nil
function MonitorEx:setPos(pos)
    if pos ~= nil then
        self.monitor.setCursorPos(pos.x, pos.y)
    end
end

--- Draws a horizontal colored bar at the given position
--- @param pos vec2 | nil
--- @param size number Integer length of the bar in characters
--- @param color ccTweaked.colors.color
function MonitorEx:drawEmptyGauge(pos, size, color)
    self.monitor.setBackgroundColor(color)
    self:setPos(pos)
    self.monitor.write(string.rep(" ", size))
end

--- Draws a horizontal bi-colored bar at the given position
--- The left portion up to size*percent characters is color,
--- and the rest of the size is bgColor.
--- @param pos vec2
--- @param size number Integer length of the bar in characters
--- @param percent number Float from 0 to 1
--- @param color ccTweaked.colors.color The filled color
--- @param bgColor ccTweaked.colors.color The empty color
function MonitorEx:drawGauge(pos, size, percent, color, bgColor)
    self:setPos(pos)

    local clamped_01 = math.max(math.min(percent, 1), 0)
    local u = math.floor(size * clamped_01 + 0.5)
    local v = size - u

    self:drawEmptyGauge(nil, u, color)
    self:drawEmptyGauge(nil, v, bgColor)
end

--- Construct a new MonitorEx instance using a monitor from the given side (or modem address?)
--- @param side ccTweaked.peripherals.computerSide
--- @return fi.dea.ccLib.monitor.MonitorEx
function exports.new(side)
    --- @type ccTweaked.peripherals.Monitor
    local monitor = _ENV.Dea.Peripheral.getRequired("monitor", side)
    local w, h = monitor.getSize()

    local instance = setmetatable({}, MonitorEx)
    instance.monitor = monitor
    instance.size = vec2(w, h)

    return instance
end

return exports