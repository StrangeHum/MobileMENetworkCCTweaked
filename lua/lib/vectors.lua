--- @module "fi.dea.ccLib.vectors"
--- @class fi.dea.ccLib.vectors

local exports = {}

--- @class vec2
--- @field x number
--- @field y number
local vec2 = {}
vec2.__index = vec2

---@param x number | nil
---@param y number | nil
---@return vec2
function _G.vec2(x, y)
    local res = nil

    if x == nil then
        res = { x=0, y=0 }
    elseif y ~= nil then
        res = { x=x, y=y }
    else
        res = { x=x, y=x }
    end

    local instance = setmetatable({}, vec2)
    instance.x = res.x
    instance.y = res.y
    
    return instance
end

function vec2:__add(a, b)
    return vec2(a.x + b.x, a.y + b.y)
end

function vec2:__sub(a, b)
    return vec2(a.x - b.x, a.y - b.y)
end

function vec2:__mul(a, b)
    return vec2(a.x * b.x, a.y * b.y)
end

function vec2:__div(a, b)
    return vec2(a.x / b.x, a.y / b.y)
end

exports.vec2 = vec2

return exports