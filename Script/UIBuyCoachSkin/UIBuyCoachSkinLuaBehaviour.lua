local View = require("UIBuyCoachSkin/UIBuyCoachSkinView")
local DataModel = require("UIBuyCoachSkin/UIBuyCoachSkinDataModel")
local Controller = require("UIBuyCoachSkin/UIBuyCoachSkinController")
local ViewFunction = require("UIBuyCoachSkin/UIBuyCoachSkinViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.initParamsData)
  end,
  deserialize = function(initParams)
    DataModel.initParamsData = Json.decode(initParams)
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
