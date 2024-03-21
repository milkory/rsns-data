local CommonItem = require("Common/BtnItem")
local View = require("UIActiveStore/UIActiveStoreView")
local Controller = require("UIActiveStore/UIActiveStoreController")
local DataModel = require("UIActiveStore/UIActiveStoreDataModel")
local ViewFunction = {
  ActiveStore_Group_NPC_Btn_Chat_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  ActiveStore_Group_Right_NewScrollGrid_CommodityList_SetGrid = function(element, elementIndex)
    local row = DataModel.StoreList[tonumber(elementIndex)]
    local ca = row.ca
    row.name = ca.commodityName
    row.image = ca.commodityView
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_CommodityName:SetText(ca.commodityName)
    Btn_Item.Txt_PurchaseNum:SetActive(ca.purchase == true)
    Btn_Item.Txt_PurchaseNum:SetText(string.format(GetText(80602522), row.residue))
    Btn_Item.Group_SoldOut.self:SetActive(row.isResidual)
    CommonItem:SetItem(Btn_Item.Group_Item, {
      id = ca.commodityItemList[1].id,
      num = ca.commodityNum
    })
    local moneyCA = PlayerData:GetFactoryData(ca.moneyList[1].moneyID)
    Btn_Item.Group_Money.Img_Money:SetSprite(moneyCA.buyPath)
    Btn_Item.Group_Money.Txt_Price:SetText(ca.moneyList[1].moneyNum)
  end,
  ActiveStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.StoreList[tonumber(str)]
    if row.isResidual then
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.saleOutText)
      CommonTips.OpenTips(80602917)
      return
    end
    local parmas = {}
    parmas.index = tonumber(str) - 1
    parmas.shopid = DataModel.ShopId
    parmas.id = row.id
    parmas.residue = row.residue
    local callBack = function()
      Controller:Init()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.buySuccessText)
    end
    CommonTips.OpenBuyTips(parmas, callBack)
  end,
  ActiveStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  ActiveStore_Group_TopRight_Btn__Click = function(btn, str)
  end,
  ActiveStore_StaticGrid_Coin_SetGrid = function(element, elementIndex)
    local row = DataModel.CoinList[tonumber(elementIndex)]
    if row.click == "Tips" then
      element.Btn_:SetClickParam(elementIndex)
    end
    element.Img_Money:SetSprite(row.buyPath)
    element.Txt_Num:SetText(row.num)
  end,
  ActiveStore_StaticGrid_Coin_Group_TopRight_Btn__Click = function(btn, str)
    local row = DataModel.CoinList[tonumber(str)]
    CommonTips.OpenRewardDetail(row.id)
  end,
  ActiveStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ActiveStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ActiveStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ActiveStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
