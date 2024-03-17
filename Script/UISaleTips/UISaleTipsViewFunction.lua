local View = require("UISaleTips/UISaleTipsView")
local DataModel = require("UISaleTips/UISaleTipsDataModel")
local Controller = require("UISaleTips/UISaleTipsController")
local ViewFunction = {
  SaleTips_Btn_BG_Click = function(btn, str)
    Controller:OpenSaleTips(false)
  end,
  SaleTips_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  SaleTips_Btn_Min_Click = function(btn, str)
    Controller:SetNumBtn(DataModel.EnumBtnType.Min)
  end,
  SaleTips_Btn_Dec_Click = function(btn, str)
    Controller:SetNumBtn(DataModel.EnumBtnType.Subtraction)
  end,
  SaleTips_Group_Slider_Slider_Value_Slider = function(btn, str)
    Controller:SetSlider(str)
  end,
  SaleTips_Btn_Add_Click = function(btn, str)
    Controller:SetNumBtn(DataModel.EnumBtnType.Add)
  end,
  SaleTips_Btn_Max_Click = function(btn, str)
    Controller:SetNumBtn(DataModel.EnumBtnType.Max)
  end,
  SaleTips_Btn_Cancel_Click = function(btn, str)
    Controller:OpenSaleTips(false)
  end,
  SaleTips_Btn_Sale_Click = function(btn, str)
    Controller:Sale()
  end,
  SaleTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  SaleTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end
}
return ViewFunction
