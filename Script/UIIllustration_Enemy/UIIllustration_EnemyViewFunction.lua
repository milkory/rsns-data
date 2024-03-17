local View = require("UIIllustration_Enemy/UIIllustration_EnemyView")
local Controller = require("UIIllustration_Enemy/UIIllustration_EnemyController")
local DataModel = require("UIIllustration_Enemy/UIIllustration_EnemyDataModel")
local ViewFunction = {
  Illustration_Enemy_Group_TopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Illustration_Enemy_Group_TopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Illustration_Enemy_Group_TopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Illustration_Enemy_Group_TopLeft_Btn_Help_Click = function(btn, str)
  end,
  Illustration_Enemy_Group_TopRight_Btn_All_Click = function(btn, str)
    DataModel.SortState.index = 1
    Controller:Click(View.Group_TopRight.Btn_All)
  end,
  Illustration_Enemy_Group_TopRight_Btn_Middle_Click = function(btn, str)
    DataModel.SortState.index = 2
    Controller:Click(View.Group_TopRight.Btn_Middle)
  end,
  Illustration_Enemy_Group_TopRight_Btn_Boss_Click = function(btn, str)
    DataModel.SortState.index = 3
    Controller:Click(View.Group_TopRight.Btn_Boss)
  end,
  Illustration_Enemy_Group_RightList_ScrollGrid_RightList_SetGrid = function(element, elementIndex)
    local row = DataModel.EnumCampEnumList[tonumber(elementIndex)]
    element.Btn_EnemType:SetClickParam(elementIndex)
    Controller:SetRightElement(element.Btn_EnemType, row, tonumber(elementIndex))
  end,
  Illustration_Enemy_Group_RightList_ScrollGrid_RightList_Group_Item_Btn_EnemType_Click = function(btn, str)
    Controller:ChooseRightIndex(tonumber(str))
  end,
  Illustration_Enemy_Group_Card_NewScrollGrid_EnemyCard_SetGrid = function(element, elementIndex)
    local row = DataModel.SortShowList[tonumber(elementIndex)]
    DataModel.Element[tonumber(elementIndex)] = element
    element.Btn_Card:SetClickParam(elementIndex)
    Controller:SetElement(element.Btn_Card, row, elementIndex)
  end,
  Illustration_Enemy_Group_Card_NewScrollGrid_EnemyCard_Group_Item_Btn_Card_Click = function(btn, str)
    local row = DataModel.SortShowList[tonumber(str)]
    Controller:OpenEnemyTip(row, tonumber(str))
  end,
  Illustration_Enemy_Group_Card_NewScrollGrid_EnemyCard_Group_Item_Btn_Card_Group_Unlocked_StaticGrid_Tag_SetGrid = function(element, elementIndex)
    local index = tonumber(element.ParentParam)
    local row = DataModel.SortShowList[index]
    local ability = row.abilityList[elementIndex]
    element:SetActive(false)
    if ability then
      element:SetActive(true)
      element.Img_Tag:SetSprite(ability.icon)
    end
  end
}
return ViewFunction
