local View = require("UIBuyTips/UIBuyTipsView")
local DataModel = require("UIBuyTips/UIBuyTipsDataModel")
local ViewFunction = {
  BuyTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  BuyTips_Group_Item_Btn_Item_Click = function(btn, str)
    local a = DataModel.commoditCA.commodityItemList[1]
    if a.id and a.id ~= "" then
      CommonTips.OpenPreRewardDetailTips(a.id)
    end
  end,
  BuyTips_Btn_Min_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Min)
  end,
  BuyTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Subtraction)
  end,
  BuyTips_Group_Slider_Slider_Value_Slider = function(btn, str)
    DataModel:SetSlider(str)
  end,
  BuyTips_Btn_Add_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Add)
  end,
  BuyTips_Btn_Max_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Max)
  end,
  BuyTips_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  BuyTips_Btn_Sale_Click = function(btn, str)
    DataModel:BuyCommodit()
  end,
  BuyTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  BuyTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  BuyTips_Img_Furniture_Btn_ShowTips_Click = function(btn, str)
    local id = DataModel.CommoditData.commoditData.commodityItemList[1].id
    CommonTips.OpenPreRewardDetailTips(id)
  end
}
return ViewFunction
