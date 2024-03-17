local View = require("UIIllustration_Character/UIIllustration_CharacterView")
local Controller = require("UIIllustration_Character/UIIllustration_CharacterController")
local DataModel = require("UIIllustration_Character/UIIllustration_CharacterDataModel")
local ViewFunction = {
  Illustration_Character_Group_TopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Illustration_Character_Group_TopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Illustration_Character_Group_TopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Illustration_Character_Group_TopLeft_Btn_Help_Click = function(btn, str)
  end,
  Illustration_Character_Group_RightList_ScrollGrid_RightList_SetGrid = function(element, elementIndex)
    local row = DataModel.EnumSideList[tonumber(elementIndex)]
    element.Btn_Side:SetClickParam(elementIndex)
    Controller:SetRightElement(element.Btn_Side, row, tonumber(elementIndex))
  end,
  Illustration_Character_Group_RightList_ScrollGrid_RightList_Group_Item_Btn_Side_Click = function(btn, str)
    Controller:ChooseRightIndex(tonumber(str))
  end,
  Illustration_Character_Group_Card_NewScrollGrid_Card_SetGrid = function(element, elementIndex)
    local row = DataModel.NowShowList[tonumber(elementIndex)]
    DataModel.Element[tonumber(elementIndex)] = element
    element.Btn_Card:SetClickParam(elementIndex)
    Controller:SetElement(element.Btn_Card, row)
  end,
  Illustration_Character_Group_Card_NewScrollGrid_Card_Group_Item_Btn_Card_Click = function(btn, str)
    local row = DataModel.NowShowList[tonumber(str)]
    Controller:OpenRoleTip(row, tonumber(str))
  end,
  Illustration_Character_Group_RowSelected_Btn_All_Click = function(btn, str)
    DataModel.SortStateIndex = 0
    Controller:RefreshBtn(View.Group_RowSelected.Btn_All)
  end,
  Illustration_Character_Group_RowSelected_Btn_Back_Click = function(btn, str)
    DataModel.SortStateIndex = 3
    Controller:RefreshBtn(View.Group_RowSelected.Btn_Back)
  end,
  Illustration_Character_Group_RowSelected_Btn_Middle_Click = function(btn, str)
    DataModel.SortStateIndex = 2
    Controller:RefreshBtn(View.Group_RowSelected.Btn_Middle)
  end,
  Illustration_Character_Group_RowSelected_Btn_Front_Click = function(btn, str)
    DataModel.SortStateIndex = 1
    Controller:RefreshBtn(View.Group_RowSelected.Btn_Front)
  end
}
return ViewFunction
