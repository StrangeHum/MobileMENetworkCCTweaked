--- @module "fi.dea.ccLib.models.status-v1"

--- @class fi.dea.ccLib.models.status-v1.update-v1
--- @field data table<string, fi.dea.ccLib.models.status-v1.update-v1-entry>

--- @class fi.dea.ccLib.models.status-v1.update-v1-entry
--- @field id string
--- @field type "redstone"
--- @field args table

local exports = {
    protocols = {
        updateV1 = "fi.dea.status-v1.update-v1"
    }
}

return exports