local View = require("UIShopSaleTips/UIShopSaleTipsView")
local DataModel = require("UIShopSaleTips/UIShopSaleTipsDataModel")
local Controller = require("UIShopSaleTips/UIShopSaleTipsController")
local ViewFunction = {
  ShopSaleTips_Btn_BG_Click = function(btn, str)
    Controller:Cancel()
  end,
  ShopSaleTips_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data.id)
  end,
  ShopSaleTips_Btn_Min_Click = function(btn, str)
    Controller:SetNum(1)
  end,
  ShopSaleTips_Btn_Dec_Click = function(btn, str)
    Controller:SetNum(DataModel.CurrentNum - 1)
  end,
  ShopSaleTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    Controller:SetNum(value)
  end,
  ShopSaleTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  ShopSaleTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  ShopSaleTips_Btn_Add_Click = function(btn, str)
    Controller:SetNum(DataModel.CurrentNum + 1)
  end,
  ShopSaleTips_Btn_Max_Click = function(btn, str)
    Controller:SetNum(DataModel.Data.num)
  end,
  ShopSaleTips_Btn_Cancel_Click = function(btn, str)
    Controller:Cancel()
  end,
  ShopSaleTips_Btn_Sale_Click = function(btn, str)
    Controller:Confirm()
  end,
  ShopSaleTips_Img_Furniture_Btn_ShowTips_Click = function(btn, str)
    local id = DataModel.Data.id
    CommonTips.OpenPreRewardDetailTips(id)
  end
}
return ViewFunction
