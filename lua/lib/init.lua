---@module "fi.dea.ccLib"

---@class fi.dea.ccLib
local exports = {}

exports.Peripheral = require("lib.peripheral")
exports.Inventory = require("lib.inventory")
exports.Logging = require("lib.logging")
exports.Configuration = require("lib.configuration")
exports.Redstone = require("lib.redstone")
exports.ItemfilterCcp = require("lib.itemfilter-ccp")
exports.Monitor = require("lib.monitor")
exports.Vectors = require("lib.vectors")

_ENV.Dea = exports

return exports