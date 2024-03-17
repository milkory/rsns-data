local View = require("UIAppearTips/UIAppearTipsView")
local DataModel = require("UIAppearTips/UIAppearTipsDataModel")
local ViewFunction = require("UIAppearTips/UIAppearTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.init(Json.decode(initParams))
    View.Group_Time.Txt_Time:SetText(DataModel.remain_ts)
    View.Group_Time.Txt_Time:SetText(DataModel.remain_ts)
    local starInt = DataModel.levelStarInt
    for i = 1, 5 do
      local element = View.Txt_Name.Group_Star["Img_Star" .. i]
      element:SetActive(i <= starInt)
    end
    View.Txt_Name:SetText(DataModel.levelName)
    View.Group_Slider.Slider_Value:SetSliderValue(0)
    local color = PlayerData:GetUserInfo().gold >= DataModel.pay_min and "#FFFFFF" or "#FF0000"
    View.Group_Gold.Txt_Num:SetText(DataModel.pay_min)
    View.Group_Gold.Txt_Num:SetColor(color)
    local is_slide = true
    if DataModel.pay_min == DataModel.pay_max or PlayerData:GetUserInfo().gold < DataModel.pay_min then
      is_slide = false
    end
    View.Group_Slider.Slider_Value.slider.interactable = is_slide
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
