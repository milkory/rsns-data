local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local Controller = require("UIBarStore/UIBarStoreController")
local ViewFunction = {
  BarStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Main.Group_Drink.self.IsActive then
      Controller:DrinkReturnToMain()
      return
    elseif View.Group_LocalStore.self.IsActive then
      Controller:StoreReturnToMain()
      return
    end
    UIManager:GoBack()
  end,
  BarStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  BarStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303385}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  BarStore_Group_Main_Btn_Drink_Click = function(btn, str)
    Controller:OpenDrink()
  end,
  BarStore_Group_Main_Btn_Store_Click = function(btn, str)
    Controller:OpenStore()
  end,
  BarStore_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  BarStore_Group_Main_Group_Drink_Group_Energy_Btn_Energy_Click = function(btn, str)
  end,
  BarStore_Group_Main_Group_Drink_StaticGrid_Drink_SetGrid = function(element, elementIndex)
    local info = DataModel.DrinkInfo[elementIndex]
    local listCA = PlayerData:GetFactoryData(info.id, "ListFactory")
    local select = DataModel.DrinkCurCount
    if select > #listCA.drinkList then
      select = #listCA.drinkList
    end
    local costInfo = listCA.drinkList[select]
    local name = info.name
    local energySub = info.powerReduce
    local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
    element.Txt_Name:SetText(name)
    if costInfo.num == 0 or PlayerData:GetHomeInfo().free_drink == 0 then
      element.Img_Item:SetActive(false)
      element.Txt_Cost:SetActive(false)
      element.Txt_Free:SetActive(true)
    else
      element.Img_Item:SetActive(true)
      element.Txt_Cost:SetActive(true)
      element.Txt_Free:SetActive(false)
      element.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
      element.Txt_Cost:SetText(costInfo.num)
    end
    element.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
    element.Txt_Cost:SetText(costInfo.num)
    element.Btn_Click:SetClickParam(elementIndex)
  end,
  BarStore_Group_Main_Group_Drink_StaticGrid_Drink_Group_Drink_Btn_Click_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:Drink(idx)
  end,
  BarStore_Group_LocalStore_Group_StoreList_ScrollGrid_Commodity_SetGrid = function(element, elementIndex)
    Controller:RefreshCommodityShow(element, elementIndex)
  end,
  BarStore_Group_LocalStore_Group_StoreList_ScrollGrid_Commodity_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_List.shopList[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    if row.buyLimit then
      CommonTips.OpenTips(80601023)
      return
    end
    if row.endTime and TimeUtil:GetServerTimeStamp() > row.endTime then
      CommonTips.OpenTips(80601523)
      DataModel.RefreshShopDataDetail()
      View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
      View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
      return
    end
    row.commoditData = PlayerData:GetFactoryData(row.id)
    row.index = row.idx - 1
    row.shopid = DataModel.ShopId
    row.name = row.commoditData.commodityName
    row.image = row.commoditData.commodityView
    row.qualityInt = row.commoditData.qualityInt + 1
    CommonTips.OpenBuyTips(row, function(cnt)
      Controller:RefreshResource()
      DataModel.Now_List.server = PlayerData.ServerData.shops[tostring(DataModel.ShopId)]
      DataModel.RefreshShopDataDetail()
      View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
      View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
    end)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Btn_ShuaXin_Click = function(btn, str)
    Controller:RefreshShop()
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_HS_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_HS_Btn_Add_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_LV_Click = function(btn, str)
    CommonTips.OpenRewardDetail(11400017)
  end,
  BarStore_Group_LocalStore_Group_Ding_Btn_LV_Btn_Add_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      homeCommon.SetReputationElement(View.Group_LocalStore.Group_Reputation, DataModel.StationId)
    end)
  end,
  BarStore_Group_Main_Group_NpcInfo_Group_1_Btn_Tips_Click = function(btn, str)
    View.Group_Main.Group_NpcInfo.Group_Tips1.self:SetActive(true)
  end,
  BarStore_Group_Main_Group_NpcInfo_Group_Tips1_Btn_Close_Click = function(btn, str)
    View.Group_Main.Group_NpcInfo.Group_Tips1.self:SetActive(false)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Time_Img_1_Btn__Click = function(btn, str)
    View.Group_LocalStore.Group_Tips2.self:SetActive(true)
  end,
  BarStore_Group_TishiWindow_Btn_Close_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  BarStore_Group_TishiWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    local isActive = View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
    View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(not isActive)
  end,
  BarStore_Group_TishiWindow_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmReplaceBuff()
  end,
  BarStore_Group_TishiWindow_Btn_Cancel_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  BarStore_Group_Buff_Btn_Close_Click = function(btn, str)
    View.Group_Buff.self:SetActive(false)
  end,
  BarStore_Video_Drink_Skip_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_Skip")
    View.Group_Skip.self:SetActive(true)
  end,
  BarStore_Group_Skip_Btn_BG_Click = function(btn, str)
    Controller:CloseSkip()
  end,
  BarStore_Group_Skip_Btn_Confirm_Click = function(btn, str)
    Controller:VideoSkip()
  end,
  BarStore_Group_Skip_Btn_Cancel_Click = function(btn, str)
    Controller:CloseSkip()
  end,
  BarStore_Group_Skip_Group_Tip_Btn_Tip_Click = function(btn, str)
    local isSelect = View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self.IsActive
    View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self:SetActive(not isSelect)
  end,
  BarStore_Btn_Skip_Click = function(btn, str)
    local checkTime = PlayerData:GetPlayerPrefs("int", "ShowDrinkVideo")
    if 0 < checkTime then
      Controller:VideoSkip()
    else
      UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_Skip")
      View.Group_Skip.self:SetActive(true)
    end
  end,
  BarStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Tab_Group_Headquarters_Btn__Click = function(btn, str)
    Controller:ChooseTab(1)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Tab_Group_Local_Btn__Click = function(btn, str)
    Controller:ChooseTab(2)
  end,
  BarStore_Group_LocalStore_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end
}
return ViewFunction
