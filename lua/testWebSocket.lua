local ws = assert(http.websocket("wss://localhost/menet"))
ws.send("Hello!") -- Send a message
print(ws.receive()) -- And receive the reply
ws.close()