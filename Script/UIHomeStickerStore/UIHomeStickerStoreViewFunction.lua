local View = require("UIHomeStickerStore/UIHomeStickerStoreView")
local DataModel = require("UIHomeStickerStore/UIHomeStickerStoreDataModel")
local Controller = require("UIHomeStickerStore/UIHomeStickerStoreController")
local ViewFunction = {
  HomeStickerStore_Btn_Mask_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  HomeStickerStore_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local itemList = DataModel.ItemList
    local data = PlayerData:GetFactoryData(itemList[elementIndex].id, "CommodityFactory")
    element.Img_Mask.Img_Item:SetSprite(data.commodityView)
    element.Txt_Name:SetText(data.commodityName)
    element.Group_Money.Group_Money.Img_Money:SetSprite(data.monetaryView)
    element.Group_Money.Txt_MoneyNum:SetText(data.moneyList[1].moneyNum)
    element.Btn_Select:SetClickParam(elementIndex)
  end,
  HomeStickerStore_ScrollGrid_Item_Group_Item_Btn_Select_Click = function(btn, str)
    Controller:GeneralBuyClickItem(str)
  end
}
return ViewFunction
