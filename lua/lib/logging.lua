--- @module "fi.dea.ccLib.logging"
--- @class fi.dea.ccLib.logging

local exports = {}

--- Print to network
function exports.net(arg)
    local str = arg
        and textutils.serializeJSON(arg)
        or "null"
    print(str)

    local s,_,e = pcall(exports._net, str)

    if not s then
        print("Network error logging: " .. tostring(e))
    end
end

function exports._net(str)
    local _ = http.post(
        "http://localhost:5000/print2",
        str,
        { ["Content-Type"] = "text/plain" }
    )
end

--- Print out all args (with JSON formatting for non-strings)
function exports.print(...)
    local args = table.pack(...)
    local parts = {}

    for i = 1, args.n do
        local arg = args[i]
        if type(arg) == "string" then
            parts[i] = arg
        elseif arg ~= nil then
            parts[i] = textutils.serializeJSON(arg)
        else
            parts[i] = "null"
        end
    end

    local str = table.concat(parts, " ")
    print(str)
end

return exports