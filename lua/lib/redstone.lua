--- @module "fi.dea.ccLib.redstone"
--- @class fi.dea.ccLib.redstone

local exports = {}

--- @class fi.dea.ccLib.redstone.wrappedSide
--- @field side ccTweaked.peripherals.computerSide
local wrappedSide = {}

--- Set redstone on this side to signal
---@param signal boolean
function wrappedSide:set(signal)
    redstone.setOutput(self.side, signal)
end

--- Set redstone on this side to high for duration seconds, and then to low
---@param duration number
function wrappedSide:pulseHigh(duration)
    redstone.setOutput(self.side, true)
    sleep(duration)
    redstone.setOutput(self.side, false)
end

--- Set redstone on this side to low for duration seconds, and then to high
---@param duration number
function wrappedSide:pulseLow(duration)
    redstone.setOutput(self.side, false)
    sleep(duration)
    redstone.setOutput(self.side, true)
end

---@param side ccTweaked.peripherals.computerSide
---@return fi.dea.ccLib.redstone.wrappedSide
function exports.wrap(side)
    local instance = {
        side = side
    }

    setmetatable(instance, { __index = wrappedSide })

    return instance
end

return exports