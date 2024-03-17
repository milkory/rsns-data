local View = require("UIHomeStore/UIHomeStoreView")
local DataModel = require("UIHomeStore/UIHomeStoreDataModel")
local Controller = require("UIHomeStore/UIHomeStoreController")
local CoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local UIBuyTipsDataModel = require("UIBuyTips/UIBuyTipsDataModel")
local ViewFunction = {
  HomeStore_Group_FurnitureStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local idx = tonumber(elementIndex)
    element.Btn_Item:SetClickParam(idx)
    local row = DataModel.Now_List.shopFactory.shopList[idx]
    local data = PlayerData:GetFactoryData(row.id)
    element.Btn_Item.Txt_ItemName:SetText(data.commodityName)
    element.Btn_Item.Img_ItemBG.Img_Item:SetSprite(data.commodityView)
    local Item = PlayerData:GetFactoryData(data.commodityItemList[1].id)
    local quantity = Item.rarityInt
    element.Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity + 1])
    if DataModel.Now_List.server then
      for k, v in pairs(DataModel.Now_List.server.items) do
        if tonumber(v.id) == tonumber(row.id) then
          row.py_cnt = v.py_cnt
        end
      end
    end
    local purchase = data.purchase
    if purchase == true then
      row.residue = data.purchaseNum - (row.py_cnt or 0)
      if row.residue < 0 then
        row.residue = 0
      end
      element.Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("剩余:" .. row.residue)
      if row.residue == 0 then
        element.Btn_Item.Img_Sold.self:SetActive(true)
      else
        element.Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      row.residue = 100
      element.Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
      element.Btn_Item.Img_Sold.self:SetActive(false)
    end
    row.storeType = DataModel.Now_List.shopFactory.storeType
    element.Btn_Item.Img_ItemBG.Txt_ItemNum:SetText(data.commodityItemList[1].num)
    local money = data.moneyList[1]
    if money then
      element.Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
      element.Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      element.Btn_Item.Img_Money.Txt_MoneyNum:SetText(data.moneyList[1].moneyNum)
      return
    end
    element.Btn_Item.Img_Money:SetActive(false)
  end,
  HomeStore_Group_FurnitureStore_ScrollGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_List.shopFactory.shopList[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    row.commoditData = PlayerData:GetFactoryData(row.id)
    row.index = tonumber(str) - 1
    row.shopid = DataModel.ShopId
    row.name = row.commoditData.commodityName
    row.image = row.commoditData.commodityView
    row.qualityInt = row.commoditData.qualityInt
    CommonTips.OpenBuyTips(row, function(cnt)
      CoachDataModel.ResetFurnitureTypeData()
    end)
    View.self:Confirm()
  end,
  HomeStore_ScrollGrid_StoreList_SetGrid = function(element, elementIndex)
    local idx = tonumber(elementIndex)
    element.Btn_FurnitureStore:SetClickParam(idx)
    local data = DataModel.List[idx]
    element.Btn_FurnitureStore.Img_pitchon:SetActive(false)
    element.Btn_FurnitureStore.Txt_Name:SetText(data.shopFactory.storeName)
  end,
  HomeStore_ScrollGrid_StoreList_Group_Item_Btn_FurnitureStore_Click = function(btn, str)
    local index = tonumber(str)
    Controller:ChooseTab(index)
  end,
  HomeStore_Group_PropBuy_Btn_Close_Click = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Group_Middle_Btn_Reduce_Click = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Group_Middle_Btn_Reduce_LongPress = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Group_Middle_Btn_Add_Click = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Group_Middle_Btn_Add_LongPress = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Group_Middle_Btn_Max_Click = function(btn, str)
  end,
  HomeStore_Group_PropBuy_Group_Right_Btn_Buy_Click = function(btn, str)
  end,
  HomeStore_Group_SuccessfulPurchase_Btn_Close_Click = function(btn, str)
  end,
  HomeStore_Group_LackMoney_Btn_Close_Click = function(btn, str)
  end,
  HomeStore_Group_LackMoney_Btn_Confirm_Click = function(btn, str)
  end,
  HomeStore_Group_LackMoney_Btn_Cancel_Click = function(btn, str)
  end,
  HomeStore_Group_RefreshWindow_Btn_Close_Click = function(btn, str)
  end,
  HomeStore_Group_RefreshWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
  end,
  HomeStore_Group_RefreshWindow_Btn_Confirm_Click = function(btn, str)
  end,
  HomeStore_Group_RefreshWindow_Btn_Cancel_Click = function(btn, str)
  end,
  HomeStore_Group_TopRight_Btn_Diamond_Click = function(btn, str)
  end,
  HomeStore_Group_TopRight_Btn_Gold_Click = function(btn, str)
  end,
  HomeStore_Group_TopRight_Btn_FurnitureCoin_Click = function(btn, str)
  end,
  HomeStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
