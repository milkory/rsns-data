local View = require("UISale/UISaleView")
local DataModel = require("UISale/UISaleDataModel")
local Controller = require("UISale/UISaleController")
local ViewFunction = {
  Sale_Group_Sale_Btn_TabItem_Click = function(btn, str)
    Controller:RefreshGrid(EnumDefine.Depot.Item)
  end,
  Sale_Group_Sale_Btn_TabMaterial_Click = function(btn, str)
    Controller:RefreshGrid(EnumDefine.Depot.Material)
  end,
  Sale_Group_Sale_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_Sale.ScrollGrid_Materials.grid.self:MoveToTop()
    UIManager:GoBack()
  end,
  Sale_Group_Sale_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.Group_Sale.ScrollGrid_Materials.grid.self:MoveToTop()
    UIManager:GoHome()
  end,
  Sale_Group_Sale_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Sale_Group_SaleTips_Btn_BG_Click = function(btn, str)
    Controller:OpenSaleTips(false)
  end,
  Sale_Group_SaleTips_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:OpenShowItem()
  end,
  Sale_Group_SaleTips_Btn_Min_Click = function(btn, str)
    Controller:SetNumBtn(3)
  end,
  Sale_Group_SaleTips_Btn_Dec_Click = function(btn, str)
    Controller:SetNumBtn(1)
  end,
  Sale_Group_SaleTips_Btn_Add_Click = function(btn, str)
    Controller:SetNumBtn(0)
  end,
  Sale_Group_SaleTips_Btn_Max_Click = function(btn, str)
    Controller:SetNumBtn(2)
  end,
  Sale_Group_SaleTips_Btn_Cancel_Click = function(btn, str)
    Controller:OpenSaleTips(false)
  end,
  Sale_Group_SaleTips_Btn_Sale_Click = function(btn, str)
    Controller:Sale()
  end,
  Sale_Group_Sale_ScrollGrid_Items_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    Controller:SetElement(element, DataModel.Data[EnumDefine.Depot.Item][elementIndex], true)
  end,
  Sale_Group_Sale_ScrollGrid_Items_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:OpenSaleTips(true, DataModel.Data[EnumDefine.Depot.Item][tonumber(str)])
  end,
  Sale_Group_Sale_ScrollGrid_Materials_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    Controller:SetElement(element, DataModel.Data[EnumDefine.Depot.Material][elementIndex], true)
  end,
  Sale_Group_Sale_ScrollGrid_Materials_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:OpenSaleTips(true, DataModel.Data[EnumDefine.Depot.Material][tonumber(str)])
  end,
  Sale_Group_SaleTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    Controller:SetSlider(value)
  end
}
return ViewFunction
