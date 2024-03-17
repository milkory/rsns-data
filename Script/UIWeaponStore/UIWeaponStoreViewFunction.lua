local DataModel = require("UIWeaponStore/UIWeaponStoreDataModel")
local ViewFunction = {
  WeaponStore_Group_Right_Btn_Button_Click = function(btn, str)
    DataModel:OnClickBtnPreview()
  end,
  WeaponStore_Group_Bottom_Group_Btn_Btn__Click = function(btn, str)
    DataModel:OnClickExchange()
  end,
  WeaponStore_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  WeaponStore_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  WeaponStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  WeaponStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  WeaponStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  WeaponStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  WeaponStore_Group_Cost_ScrollGrid_Sale_SetGrid = function(element, elementIndex)
    DataModel:OnCommodityListSetGrid(element, elementIndex)
  end,
  WeaponStore_Group_Cost_ScrollGrid_Sale_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OnSelectItem(tonumber(str))
  end,
  WeaponStore_Group_Bottom_ScrollGrid_Cost_SetGrid = function(element, elementIndex)
    DataModel:OnCostListSetGrid(element, elementIndex)
  end,
  WeaponStore_Group_Bottom_ScrollGrid_Cost_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel:OnClickCostItem(str)
  end
}
return ViewFunction
