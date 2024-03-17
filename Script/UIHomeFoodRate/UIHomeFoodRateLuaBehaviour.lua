local View = require("UIHomeFoodRate/UIHomeFoodRateView")
local DataModel = require("UIHomeFoodRate/UIHomeFoodRateDataModel")
local ViewFunction = require("UIHomeFoodRate/UIHomeFoodRateViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    local hid = param.hid
    DataModel.hid = hid
    DataModel.mealId = param.mealId
    DataModel.starNum = 0
    DataModel.starDescList = PlayerData:GetFactoryData(99900014, "ConfigFactory").rateBento
    local heroCA = PlayerData:GetFactoryData(hid, "UnitFactory")
    View.Img_PicBg.Img_Avatar:SetSprite(PlayerData:GetFactoryData(heroCA.skinList[1].unitViewId).face)
    ViewFunction.RefreshUI()
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
