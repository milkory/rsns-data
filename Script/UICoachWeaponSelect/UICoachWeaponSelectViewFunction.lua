local View = require("UICoachWeaponSelect/UICoachWeaponSelectView")
local DataModel = require("UICoachWeaponSelect/UICoachWeaponSelectDataModel")
local Controller = require("UICoachWeaponSelect/UICoachWeaponSelectController")
local ViewFunction = {
  CoachWeaponSelect_Group_SelectWindows_Group_Left_ScrollGrid_TrainWeapon_SetGrid = function(element, elementIndex)
    Controller:RefreshLeftWeaponElement(element, elementIndex)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Left_ScrollGrid_TrainWeapon_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickWeapon(tonumber(str))
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Right_Group_Button_Btn_All_Click = function(btn, str)
    Controller:ClickWeaponOperatorBtn()
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Right_Group_Button_Btn_Level_Click = function(btn, str)
    Controller:ClickWeaponLevelUpBtn()
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Left_Btn_Sort_Click = function(btn, str)
    Controller:ClickSortBtn()
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_SortButton_Btn_Weapon_Click = function(btn, str)
    Controller:SelectTrainOrOther(DataModel.ShowType.Train)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_SortButton_Btn_Annex_Click = function(btn, str)
    Controller:SelectTrainOrOther(DataModel.ShowType.Other)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_TrainHead_Btn_Add1_Click = function(btn, str)
    Controller:ClickTrainWeaponElement(0, 1)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_TrainHead_Btn_Add1_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_TrainHead_Btn_Add2_Click = function(btn, str)
    Controller:ClickTrainWeaponElement(0, 2)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_TrainHead_Btn_Add2_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Carriage_StaticGrid_Add_SetGrid = function(element, elementIndex)
    Controller:RefreshTrainWeaponElement(element.Btn_Add, elementIndex, 1)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Carriage_StaticGrid_Add_Group_AddWeapon_Btn_Add_Click = function(btn, str)
    Controller:ClickTrainWeaponElement(tonumber(str), 1)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Carriage_StaticGrid_Add_Group_AddWeapon_Btn_Add_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Accessory_StaticGrid_Accessory_SetGrid = function(element, elementIndex)
    Controller:RefreshOtherWeaponElement(element, elementIndex, DataModel.WeaponType.Parts)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Accessory_StaticGrid_Accessory_Group_Accessory_Group_Have_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Accessory_StaticGrid_Accessory_Group_Accessory_Group_Have_Btn_Zhaozi_Click = function(btn, str)
    Controller:ClickPartsWeaponElement(tonumber(str))
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Accessory_StaticGrid_Accessory_Group_Accessory_Group_Empty_Btn_Empty_Click = function(btn, str)
    Controller:ClickPartsWeaponElement(tonumber(str))
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Pendant_StaticGrid_Pendant_SetGrid = function(element, elementIndex)
    Controller:RefreshOtherWeaponElement(element, elementIndex, DataModel.WeaponType.Pendant)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Pendant_StaticGrid_Pendant_Group_Accessory_Group_Have_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Pendant_StaticGrid_Pendant_Group_Accessory_Group_Have_Btn_Zhaozi_Click = function(btn, str)
    Controller:ClickPendantWeaponElement(tonumber(str))
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Bottom_Group_Pendant_StaticGrid_Pendant_Group_Accessory_Group_Empty_Btn_Empty_Click = function(btn, str)
    Controller:ClickPendantWeaponElement(tonumber(str))
  end,
  CoachWeaponSelect_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:Exit()
  end,
  CoachWeaponSelect_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    Controller:GoHome()
  end,
  CoachWeaponSelect_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CoachWeaponSelect_Img_HaveelectricBg_Btn_Add_Click = function(btn, str)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Center_Img_CoreBase_StaticGrid_Type_SetGrid = function(element, elementIndex)
    Controller:RefreshCoreList(element, elementIndex)
  end,
  CoachWeaponSelect_Group_SelectWindows_Group_Center_Img_CoreBase_Btn_LevelUp_Click = function(btn, str)
    UIManager:Open("UI/EngineCore/EngineCore")
  end,
  CoachWeaponSelect_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end
}
return ViewFunction
