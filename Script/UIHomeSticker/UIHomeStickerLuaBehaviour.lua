local View = require("UIHomeSticker/UIHomeStickerView")
local DataModel = require("UIHomeSticker/UIHomeStickerDataModel")
local Controller = require("UIHomeSticker/UIHomeStickerController")
local ViewFunction = require("UIHomeSticker/UIHomeStickerViewFunction")
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
    HomeCharacterManager:RecycleChangeSkinCharacter()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
