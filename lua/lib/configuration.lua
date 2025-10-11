--- @module "fi.dea.ccLib.configuration"
--- @class fi.dea.ccLib.configuration

local exports = {}

---comment
---@param path string[]
---@return table
function exports.readJson(path)
    local fullPath = table.concat(path, "/") .. ".json"

    local h = fs.open(fullPath, "r")
    
    if not h then
        error("File does not exist: " .. path)
    end

    local textContent = h.readAll()
    h.close()

    ---@cast textContent string
    
    local jsonContent, jsonError = textutils.unserialiseJSON(textContent)

    if jsonError then
        error("Error: " .. jsonError)
    end
    
    if not jsonContent then
        error("Error, empty config")
    end

    return jsonContent
end

return exports