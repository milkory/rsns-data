local View = require("UIUseItem/UIUseItemView")
local DataModel = require("UIUseItem/UIUseItemDataModel")
local Controller = require("UIUseItem/UIUseItemController")
local ViewFunction = require("UIUseItem/UIUseItemViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Params)
  end,
  deserialize = function(initParams)
    DataModel.Params = Json.decode(initParams)
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
