local View = require("UIConvertTips/UIConvertTipsView")
local DataModel = require("UIConvertTips/UIConvertTipsDataModel")
local ViewFunction = {
  ConvertTips_Btn_BG_Click = function(btn, str)
  end,
  ConvertTips_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  ConvertTips_Btn_Min_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Min)
  end,
  ConvertTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Subtraction)
  end,
  ConvertTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:SetSlider(value)
  end,
  ConvertTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  ConvertTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  ConvertTips_Btn_Add_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Add)
  end,
  ConvertTips_Btn_Max_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Max)
  end,
  ConvertTips_Btn_Cancel_Click = function(btn, str)
    View.self:Confirm()
    UIManager:GoBack()
  end,
  ConvertTips_Btn_Sale_Click = function(btn, str)
    DataModel:Recycled()
  end
}
return ViewFunction
