local View = require("UIHomeStickerStore/UIHomeStickerStoreView")
local DataModel = require("UIHomeStickerStore/UIHomeStickerStoreDataModel")
local ViewFunction = require("UIHomeStickerStore/UIHomeStickerStoreViewFunction")
local Controller = require("UIHomeStickerStore/UIHomeStickerStoreController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:Init()
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
