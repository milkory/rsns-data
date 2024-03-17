local View = require("UIUseTips/UIUseTipsView")
local DataModel = require("UIUseTips/UIUseTipsDataModel")
local ViewFunction = {
  UseTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
  end,
  UseTips_Group_Energy_Group_Num_Btn_Min_Click = function(btn, str)
    DataModel:SetEnergyNumBtn(DataModel.EnumEnergyBtnType.Min)
  end,
  UseTips_Group_Energy_Group_Num_Btn_Dec_Click = function(btn, str)
    DataModel:SetEnergyNumBtn(DataModel.EnumEnergyBtnType.Subtraction)
  end,
  UseTips_Group_Energy_Group_Num_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:SetEnergySlider(value)
  end,
  UseTips_Group_Energy_Group_Num_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  UseTips_Group_Energy_Group_Num_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  UseTips_Group_Energy_Group_Num_Btn_Add_Click = function(btn, str)
    DataModel:SetEnergyNumBtn(DataModel.EnumEnergyBtnType.Add)
  end,
  UseTips_Group_Energy_Group_Num_Btn_Max_Click = function(btn, str)
    DataModel:SetEnergyNumBtn(DataModel.EnumEnergyBtnType.Max)
  end,
  UseTips_Group_Other_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  UseTips_Group_Other_Btn_Min_Click = function(btn, str)
    DataModel:SetOtherNumBtn(DataModel.EnumOtherBtnType.Min)
  end,
  UseTips_Group_Other_Btn_Dec_Click = function(btn, str)
    DataModel:SetOtherNumBtn(DataModel.EnumOtherBtnType.Subtraction)
  end,
  UseTips_Group_Other_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:SetOtherSlider(value)
  end,
  UseTips_Group_Other_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  UseTips_Group_Other_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  UseTips_Group_Other_Btn_Add_Click = function(btn, str)
    DataModel:SetOtherNumBtn(DataModel.EnumOtherBtnType.Add)
  end,
  UseTips_Group_Other_Btn_Max_Click = function(btn, str)
    DataModel:SetOtherNumBtn(DataModel.EnumOtherBtnType.Max)
  end,
  UseTips_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end,
  UseTips_Btn_Use_Click = function(btn, str)
    DataModel:UseEnergy()
  end
}
return ViewFunction
