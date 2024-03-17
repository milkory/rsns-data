local CommonItem = require("Common/BtnItem")
local View = require("UIMoonthCard/UIMoonthCardView")
local DataModel = require("UIMoonthCard/UIMoonthCardDataModel")
local ViewFunction = {
  MoonthCard_Btn_BG_Click = function(btn, str)
    DataModel.ClickBG()
  end,
  MoonthCard_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local row = DataModel.DropAwardList[tonumber(elementIndex)]
    CommonItem:SetItem(element.Group_Item, {
      id = row.id,
      num = row.num or row.server.num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(tostring(elementIndex))
  end,
  MoonthCard_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.DropAwardList[tonumber(str)]
    CommonTips.OpenPreRewardDetailTips(row.id, row)
  end
}
return ViewFunction
