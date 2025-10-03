local json = require("json") -- если нет, можно через textutils.serializeJSON
local me = peripheral.wrap("meBridge_0") -- адаптируй к имени твоего моста
local url = "http://192.168.0.100:5000/upload" -- адрес твоего сервера

--- Получить список предметов и собрать JSON
local function collectItems()
    local items = me.listItems()
    local result = {}

    for _, item in ipairs(items) do
        table.insert(result, {
            id = item.name,
            count = item.amount,
            craftable = item.isCraftable or false
        })
    end

    return result
end

--- Отправить на сервер
local function sendData()
    local payload = {
        items = collectItems()
    }

    local body = textutils.serializeJSON(payload)
    print("Отправляю " .. #payload.items .. " предметов")

    local res = http.post(url, body, {["Content-Type"] = "application/json"})
    if res then
        local response = res.readAll()
        res.close()
        print("Ответ от сервера: " .. response)
    else
        print("Ошибка HTTP")
    end
end

-- Запуск
while true do
    sendData()
    sleep(10) -- раз в 10 сек
end