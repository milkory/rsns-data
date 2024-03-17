local View = require("UIThemeTips/UIThemeTipsView")
local DataModel = require("UIThemeTips/UIThemeTipsDataModel")
local ViewFunction = require("UIThemeTips/UIThemeTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    local config = PlayerData:GetFactoryData(param.id, "HomeTemplateFactory")
    View.Group_Show.Img_Icon:SetSprite(config.iconPath)
    View.Group_Show.Txt_Name:SetText(config.name)
    View.Group_Show.Txt_Describe:SetText(config.describe)
    local v2 = 0
    local v4 = 0
    for i, dv in pairs(config.furnitures) do
      local config = PlayerData:GetFactoryData(dv.id, "HomeFurnitureFactory")
      v4 = v4 + config.comfort
    end
    View.Group_Show.Txt_Comfort:SetText(v4)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
