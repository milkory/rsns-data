local View = require("UIUseItem/UIUseItemView")
local DataModel = require("UIUseItem/UIUseItemDataModel")
local Controller = require("UIUseItem/UIUseItemController")
local ViewFunction = {
  UseItem_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end,
  UseItem_Img_BG_ScrollGrid_ItemList_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  UseItem_Img_BG_ScrollGrid_ItemList_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ElementBtnItemClick(btn, str)
  end,
  UseItem_Img_BG_ScrollGrid_ItemList_Group_Item_Btn_Use_Click = function(btn, str)
    Controller:ElementUseClick(btn, str)
  end
}
return ViewFunction
