local View = require("UIGroup_BuyItem/UIGroup_BuyItemView")
local DataModel = require("UIGroup_BuyItem/UIGroup_BuyItemDataModel")
local ViewFunction = require("UIGroup_BuyItem/UIGroup_BuyItemViewFunction")
local CommonItem = require("Common/BtnItem")
local Luabehaviour = {
  serialize = function()
    return Json.encode({
      maxNum = DataModel.MaxNum,
      id = DataModel.Id
    })
  end,
  deserialize = function(initParams)
    if not initParams then
      return
    end
    local data = Json.decode(initParams)
    local commodity = PlayerData:GetFactoryData(data.id, "CommodityFactory")
    local num = PlayerData:GetGoodsById(commodity.commodityItemList[1].id).num
    DataModel.NeedNum = data.maxNum - num
    DataModel.MoneyId = commodity.moneyList[1].moneyID
    DataModel.MaxNum = data.maxNum
    DataModel.Id = data.id
    local detail = {
      id = data.id
    }
    CommonItem:SetItem(View.Group_Item, detail)
    local price = commodity.moneyList[1].moneyNum * DataModel.NeedNum
    DataModel.Price = price
    View.Group_Text.Txt_Price:SetText(price)
    View.Group_Text.Img_PriceIcon:SetSprite(commodity.monetaryView)
    View.Group_Text.Img_ItemIcon:SetSprite(commodity.iconPath)
    View.Group_Text.Txt_ItemNum:SetText(DataModel.NeedNum)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
