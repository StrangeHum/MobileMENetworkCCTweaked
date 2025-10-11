--- @module "fi.dea.ccLib.peripheral"
--- @class fi.dea.ccLib.peripheral

local exports = {}

--- @param peripheralType string|ccTweaked.peripherals.type
--- @param side string|ccTweaked.peripherals.computerSide
--- @return any
function exports.getRequired(peripheralType, side)
    local periph = peripheral.wrap(side)
    if periph == nil then
        error("Missing peripheral on side " .. side)
    end

    if not peripheral.hasType(periph, peripheralType) then
        error("Peripheral on side " .. side .. " is not of the right type.")
    end

    return periph
end

return exports

--- ---@module "fi.dea.ccLib.peripheral"
--- ---@class fi.dea.ccLib.peripheral
--- 
--- local exports = {}
--- 
--- ---@param peripheralType string
--- ---@param side string
--- function exports.getRequired(peripheralType, side)
---   -- impl
--- end
--- 
--- return exports