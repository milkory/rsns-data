local CommonItem = require("Common/BtnItem")
local View = require("UIEnemy_Detail/UIEnemy_DetailView")
local DataModel = require("UIEnemy_Detail/UIEnemy_DetailDataModel")
local Controller = require("UIEnemy_Detail/UIEnemy_DetailController")
local ViewFunction = {
  Enemy_Detail_ScrollView_Right_Viewport_Content_Group_Icon_Group_Identity_ScrollGrid_Identity_SetGrid = function(element, elementIndex)
    local row = DataModel.IdentityList[tonumber(elementIndex)]
    Controller:SetRightElement(element, row)
  end,
  Enemy_Detail_ScrollView_Right_Viewport_Content_Group_Icon_Group_Resistance_ScrollGrid_Resistance_SetGrid = function(element, elementIndex)
    local row = DataModel.ResistanceList[tonumber(elementIndex)]
    Controller:SetRightElement(element, row)
  end,
  Enemy_Detail_ScrollView_Right_Viewport_Content_Group_Icon_Group_Weakness_ScrollGrid_Weakness_SetGrid = function(element, elementIndex)
    local row = DataModel.WeaknessList[tonumber(elementIndex)]
    Controller:SetRightElement(element, row)
  end,
  Enemy_Detail_ScrollView_Right_Viewport_Content_Group_Drop_StaticGrid_DropItem_SetGrid = function(element, elementIndex)
    local row = DataModel.DropRewardList[tonumber(elementIndex)]
    Controller:SetDropElement(element, row)
    element.Btn_Item:SetClickParam(elementIndex)
  end,
  Enemy_Detail_ScrollView_Right_Viewport_Content_Group_Drop_StaticGrid_DropItem_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.DropRewardList[tonumber(str)].id, DataModel.DropRewardList[tonumber(str)])
  end,
  Enemy_Detail_Btn_BG_Click = function(btn, str)
    if DataModel.IsGoback then
      UIManager:GoBack()
    else
      View.self:CloseUI()
    end
  end
}
return ViewFunction
