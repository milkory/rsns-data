local View = require("UINewCarriage/UINewCarriageView")
local DataModel = require("UINewCarriage/UINewCarriageDataModel")
local ViewFunction = require("UINewCarriage/UINewCarriageViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    local coachCA = PlayerData:GetFactoryData(data.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType, "TagFactory")
    View.Group_gp.Img_CarriageType:SetSprite(tagCA.icon)
    View.Group_gp.Txt_CarriageName:SetText(coachCA.name)
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
