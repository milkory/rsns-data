local View = require("UIAppearTips/UIAppearTipsView")
local DataModel = require("UIAppearTips/UIAppearTipsDataModel")
local ViewFunction = {
  AppearTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/HomeSafe/AppearTips")
  end,
  AppearTips_Btn_Min_Click = function(btn, str)
    View.Group_Slider.Slider_Value:SetSliderValue(0)
  end,
  AppearTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    local value_num = DataModel.pay_min + math.floor((DataModel.pay_max - DataModel.pay_min) * value)
    View.Group_Gold.Txt_Num:SetText(value_num)
    DataModel.now_value = value_num
  end,
  AppearTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  AppearTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  AppearTips_Btn_Max_Click = function(btn, str)
    local value = 1
    if DataModel.pay_min == DataModel.pay_max or PlayerData:GetUserInfo().gold < DataModel.pay_min then
      value = 0
    end
    View.Group_Slider.Slider_Value:SetSliderValue(value)
  end,
  AppearTips_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/HomeSafe/AppearTips")
  end,
  AppearTips_Btn_Confirm_Click = function(btn, str)
    Net:SendProto("building.share_level", function(json)
      View.self:Confirm()
      UIManager:CloseTip("UI/Home/HomeSafe/AppearTips")
      CommonTips.OpenTips(80601333)
    end, DataModel.level_key, DataModel.now_value)
  end
}
return ViewFunction
