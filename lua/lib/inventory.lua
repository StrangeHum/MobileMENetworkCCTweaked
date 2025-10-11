--- @module "fi.dea.ccLib.inventory"
--- @class fi.dea.ccLib.inventory

local exports = {}

---@class ItemWithSlot : ccTweaked.peripherals.inventory.item
---@field slot integer

--- Tries to move a stack matching the predicate from the input inventory
--- from `from` to the output inventory at side `to`. Iteration ends on the first
--- slot matching the predicate. Returns the number of items moved, or nil.
--- @param from ccTweaked.peripherals.Inventory
--- @param predicateFrom fun(slot: integer, detail: table): boolean
--- @param to string|ccTweaked.peripherals.computerSide
--- @return ItemWithSlot|nil
exports.tryMoveSingleStack = function(from, predicateFrom, to)
    for slot, item in pairs(from.list()) do
        local detail = from.getItemDetail(slot)
        if detail ~= nil and predicateFrom(slot, detail) then
            local moved = from.pushItems(to, slot)
            return {
                name = item.name,
                count = moved,
                nbt = detail
            }
        end
    end

    return nil
end

--- @param from ccTweaked.peripherals.Inventory
--- @param predicateFrom fun(slot: integer, detail: table): boolean
--- @return ItemWithSlot|nil
exports.findItem = function(from, predicateFrom)
    for slot, item in pairs(from.list()) do
        local detail = from.getItemDetail(slot)
        if detail ~= nil and predicateFrom(slot, detail) then
            return {
                name = item.name,
                count = item.count,
                nbt = detail,
                slot = slot
            }
        end
    end

    return nil
end

return exports