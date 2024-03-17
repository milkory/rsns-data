local View = require("UIHomeStickerAcquire/UIHomeStickerAcquireView")
local DataModel = require("UIHomeStickerAcquire/UIHomeStickerAcquireDataModel")
local ViewFunction = require("UIHomeStickerAcquire/UIHomeStickerAcquireViewFunction")
local controller = require("UIHomeStickerAcquire/UIHomeStickerAcquireController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local status = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
    end
    DataModel.Data = PlayerData:SortShowItem(status)
    controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
