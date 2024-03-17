local View = require("UIShowItem/UIShowItemView")
local ItemListFunc = require("Common/BtnItem")
local DataModel = require("UIShowItem/UIShowItemDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ShowItem_ScrollGrid_Items_SetGrid = function(element, elementIndex)
    local row = DataModel.Data[tonumber(elementIndex)]
    CommonItem:SetItem(element.Group_Item, row, nil, 1, View)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_Item.Group_Extra:SetActive(row.extra == true)
  end,
  ShowItem_Btn_OK_Click = function(str)
    CommonItem:DestroyInstantiate()
    UIManager:CloseTip("UI/Common/ShowItem")
    View.self:Confirm()
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenQuestPcntUpdateTip()
  end,
  ShowItem_ScrollGrid_Items_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.Data[tonumber(str)].id, DataModel.Data[tonumber(str)])
  end
}
return ViewFunction
