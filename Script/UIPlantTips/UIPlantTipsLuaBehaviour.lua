local View = require("UIPlantTips/UIPlantTipsView")
local DataModel = require("UIPlantTips/UIPlantTipsDataModel")
local ViewFunction = require("UIPlantTips/UIPlantTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local json = Json.decode(initParams)
    DataModel.Id = json.id
    DataModel.Num = json.num
    local config = PlayerData:GetFactoryData(DataModel.Id, "HomeCreatureFactory")
    View.Group_Show.Txt_Name:SetText(config.name)
    View.Group_Show.Txt_Describe:SetText(config.des)
    View.Group_Show.Img_Icon:SetSprite(config.iconPath)
    View.Group_Show.Txt_Mood:SetText(config.PlantMood .. "/h")
    View.Group_Show.Txt_Value:SetText(config.rewards[1].num)
    View.Group_Show.Group_Num.Txt_Num:SetText(DataModel.Num)
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
