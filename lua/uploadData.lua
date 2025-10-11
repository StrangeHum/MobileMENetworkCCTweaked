local http = require("http")

local baseUrl = "http://192.168.0.105:8081"
local uploadUrl = baseUrl .. "/upload"

-- JSON данные
local data = {
    items = {
        { id = "gtceu:lapis_dust", count = 140, craftable = false, name = "lapis_dust" },
        { id = "gtceu:sapphire_dust", count = 200, craftable = true, name = "sapphire_dust" },
    }
}

-- Преобразуем таблицу в JSON
local json = textutils.serializeJSON(data)

-- Отправляем POST-запрос
local response = http.post(uploadUrl, json, { ["Content-Type"] = "application/json" })

if response then
    print("Response:", response.readAll())
    response.close()
else
    print("Failed to send data")
end
