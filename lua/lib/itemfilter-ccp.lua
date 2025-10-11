--- @module "fi.dea.ccLib.itemfilterCcp"
--- @class fi.dea.ccLib.itemfilterCcp

local exports = {}

-- See https://docs.advanced-peripherals.de/0.7/peripherals/inventory_manager/#getitems
---@class fi.dea.ccLib.itemfilterCcp.PlayerItem
---@field name string	        The registry name of the item
---@field count number	        The amount of the item
---@field maxStackSize number	Maximum stack size for the item type
---@field slot number	        The slot that the item stack is in
---@field displayName string	The item's display name
---@field tags table	        A list of item tags
---@field nbt table	            The item's nbt data

---@class Matcher
---@field item fi.dea.ccLib.itemfilterCcp.PlayerItem
---@field result boolean
---@field finished boolean
local Matcher = {}
Matcher.__index = Matcher;

function Matcher:new(item)
    local instance = setmetatable({}, self)
    instance.item = item
    instance.result = false
    instance.finished = false
    return instance
end

function Matcher:allowItem(id)
    if self.finished then
        return
    end

    if self.item.name:match("^" .. id .. "$") then
        self.result = true
        return
    end
end

function Matcher:allowTag(tag)
    if self.finished then
        return
    end

    for _, itemTag in pairs(self.item.tags) do
        if itemTag:match("^minecraft:item/" .. tag .. "$") then
            self.result = true
            return
        end
    end

    -- Block tags not available?
end

---@param item fi.dea.ccLib.itemfilterCcp.PlayerItem
---@return Matcher
function exports.new(item)
    return Matcher:new(item)
end

---@class FilterRule
---@field op FilterOp
---@field args table

---@class FilterBuilder
---@field rules table<FilterRule>
local FilterBuilder = {
    ---@enum FilterOp
    __OP = {
        allowTag = "allowTag",
        disallowTag = "disallowTag",
        allowItem = "allowItem",
        disallowItem = "disallowItem",
    },
}
FilterBuilder.__index = FilterBuilder;

---@class Filter
---@field rules table<FilterRule>
local Filter = {}
Filter.__index = Filter;

---@param tag string Item tag to match against. Block tags are not exposed via CCP.
---@return FilterBuilder
function FilterBuilder:allowTag(tag)
    table.insert(self.rules, {
        op = FilterBuilder.__OP.allowTag,
        args = {"^minecraft:item/" .. tag .. "$"}
    })

    return self
end

---@param tag string Item tag to match against. Block tags are not exposed via CCP.
---@return FilterBuilder
function FilterBuilder:disallowTag(tag)
    table.insert(self.rules, {
        op = FilterBuilder.__OP.disallowTag,
        args = {"^minecraft:item/" .. tag .. "$"}
    })

    return self
end

---@param item string Item id to match against
---@return FilterBuilder
function FilterBuilder:allowItem(item)
    table.insert(self.rules, {
        op = FilterBuilder.__OP.allowItem,
        args = {"^" .. item .. "$"}
    })

    return self
end

---@param item string Item id to match against
---@return FilterBuilder
function FilterBuilder:disallowItem(item)
    table.insert(self.rules, {
        op = FilterBuilder.__OP.disallowItem,
        args = {"^" .. item .. "$"}
    })

    return self
end

--- Convenience method that equals to calling allowItem several times
---@param items table<string> Item ids to match against
---@return FilterBuilder
function FilterBuilder:allowAnyItem(items)
    for _, item in ipairs(items) do
        self:allowItem(item)
    end

    return self
end

---@return Filter
function FilterBuilder:build()
    local instance = setmetatable({}, Filter)
    instance.rules = {}
    for index, value in ipairs(self.rules) do
        instance.rules[index] = value
    end
    return instance
end

---Create a new filter definition. It initially starts as not having matched an item,
---ie. it is a whitelist. To invert the operation use TODO. Operations are performed in sequence,
---and each rule updates the matching status. Filtering can be conditionally "finished", rendering the
---rest of the rules skipped - with TODO.
---@return FilterBuilder
function FilterBuilder.new()
    local instance = setmetatable({}, FilterBuilder)
    instance.rules = {}
    return instance
end

---@class FilterableItem
---@field id string
---@field tags table<string>

---@param item FilterableItem
function Filter:evaluate(item)
    local result = false

    for _, rule in ipairs(self.rules) do
        if rule.op == FilterBuilder.__OP.allowItem then
            if item.id:match(rule.args[1]) then
                result = true
            end
        elseif rule.op == FilterBuilder.__OP.disallowItem then
            if item.id:match(rule.args[1]) then
                result = false
            end
        elseif rule.op == FilterBuilder.__OP.allowTag then
            for _, itemTag in ipairs(item.tags) do
                if itemTag:match(rule.args[1]) then
                    result = true
                    -- TODO: break
                end
            end
        elseif rule.op == FilterBuilder.__OP.disallowTag then
            for _, itemTag in ipairs(item.tags) do
                if itemTag:match(rule.args[1]) then
                    result = false
                    -- TODO: break
                end
            end
        else
            print("[ERROR] Rule op " .. tostring(rule.op) .. " not recognized")
        end
    end

    return result
end

exports.FilterBuilder = FilterBuilder

return exports