local View = require("UIGroup_ArriveNewCity/UIGroup_ArriveNewCityView")
local DataModel = require("UIGroup_ArriveNewCity/UIGroup_ArriveNewCityDataModel")
local ViewFunction = require("UIGroup_ArriveNewCity/UIGroup_ArriveNewCityViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.CityId = tonumber(initParams)
    local cfg = PlayerData:GetFactoryData(DataModel.CityId)
    View.Img_Icon:SetSprite(cfg.iconPath)
    View.Txt_Name:SetText(cfg.name)
    View.Txt_City:SetText(GetText(cfg.textArriveFirst))
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
