local View = require("UIHomeCOC/UIHomeCOCView")
local DataModel = require("UIHomeCOC/UIHomeCOCDataModel")
local Controller = require("UIHomeCOC/UIHomeCOCController")
local HomeStoreDataModel = require("UIHomeCOC/UIHomeCOCStoreDataModel")
local HomeStoreController = require("UIHomeCOC/UIHomeCOCStoreController")
local CommonBtnItem = require("Common/BtnItem")
local ViewFunction = {
  HomeCOC_Group_Main_Btn_Quest_Click = function(btn, str)
    Controller:ClickQuestTab()
  end,
  HomeCOC_Group_Main_Btn_Store_Click = function(btn, str)
    Controller:ClickStoreTab()
  end,
  HomeCOC_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_SetGrid = function(element, elementIndex)
    local info = DataModel.OrderInfo[elementIndex]
    if info == nil then
      element.Group_AddQuest.self:SetActive(true)
      element.Group_Info.self:SetActive(false)
    else
      local isIng = info.state == 1
      element.Group_AddQuest.self:SetActive(false)
      element.Group_Info.self:SetActive(true)
      element.Group_Info.Img_Type:SetSprite(DataModel.IconPath[info.type])
      element.Group_Info.Txt_Type:SetText(GetText(DataModel.TypeTxt[info.type]))
      local color = isIng and "#000000" or "#FFFFFF"
      element.Group_Info.Img_Type:SetColor(color)
      element.Group_Info.Txt_Type:SetColor(color)
      element.Group_Info.Txt_Name:SetText(info.name)
      element.Group_Info.Btn_Info:SetClickParam(elementIndex)
      element.Group_Info.Btn_Info2:SetClickParam(elementIndex)
      element.Group_Info.Group_Time.self:SetActive(info.configLimitTime > 0)
      element.Group_Info.Img_ClientMask.Img_Client:SetSprite(info.clientIcon)
      element.Group_Info.Txt_Client:SetText(info.clientName)
      element.Group_Info.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
      element.Group_Info.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewards)
      element.Group_Info.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
      element.Group_Info.Group_Reward.ScrollGrid_Reward.grid.self:MoveToTop()
      local stationInfo = PlayerData:GetFactoryData(info.endStation, "HomeStationFactory")
      element.Group_Info.Group_Station.Txt_EndStation:SetText(stationInfo.name)
      element.Group_Info.Group_Station.Group_Ing.self:SetActive(isIng)
      element.Group_Info.Img_Btm:SetActive(not isIng)
      element.Group_Info.Img_Btm2:SetActive(isIng)
      element.Group_Info.Btn_Info.self:SetActive(not isIng)
      element.Group_Info.Btn_Info2.self:SetActive(isIng)
      if info.configLimitTime > 0 then
        element.Group_Info.Group_Time.Txt_Time:SetText(info.showTimeText)
      end
      local show = not isIng and info.isSend
      element.Group_Info.Group_NeedLoadage.self:SetActive(show)
      if show then
        element.Group_Info.Group_NeedLoadage.Txt_Num:SetText(info.space)
      end
      show = not isIng and info.isPassenger
      element.Group_Info.Group_NeedPassengerCapacity.self:SetActive(show)
      if show then
        element.Group_Info.Group_NeedPassengerCapacity.Txt_Num:SetText(info.space)
      end
    end
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_Group_Item_Group_Info_Btn_Info_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectOrder(idx)
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_Group_Item_Group_Info_Btn_Info2_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectOrder(idx)
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_Group_Item_Group_AddQuest_Btn__Click = function(btn, str)
    Controller:AddOrder()
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Btn_BG_Click = function(btn, str)
    View.Group_Quest.Group_QuestInfo.self:SetActive(false)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.OrderInfo[DataModel.CurSelectedOrderIdx].rewards[elementIndex]
    CommonBtnItem:SetItem(element.Group_Item, {
      id = info.id,
      num = info.num
    })
    element.Group_Item.Btn_Item:SetClickParam(info.id)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = id})
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Btn_Cancel_Click = function(btn, str)
    local info = DataModel.OrderInfo[DataModel.CurSelectedOrderIdx]
    Controller:CancelOrder(info)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Btn_Receive_Click = function(btn, str)
    local info = DataModel.OrderInfo[DataModel.CurSelectedOrderIdx]
    Controller:ReceiveOrder(info)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Btn_Next_Click = function(btn, str)
    if DataModel.CurSelectedOrderIdx >= #DataModel.OrderInfo then
      return
    end
    Controller:SelectOrder(DataModel.CurSelectedOrderIdx + 1)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Btn_Prev_Click = function(btn, str)
    if DataModel.CurSelectedOrderIdx <= 1 then
      return
    end
    Controller:SelectOrder(DataModel.CurSelectedOrderIdx - 1)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_Quest.Group_QuestInfo.self:SetActive(false)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_ScrollGrid_Goods_SetGrid = function(element, elementIndex)
    local info = DataModel.OrderInfo[DataModel.CurSelectedOrderIdx]
    local goods = info.goodsList[elementIndex]
    local goodsCA = PlayerData:GetFactoryData(goods.id, "HomeGoodsFactory")
    CommonBtnItem:SetItem(element.Group_Item, {
      id = goods.id,
      num = goods.num
    })
    element.Group_Item.Btn_Item:SetClickParam(goods.id)
    if not info.isSend then
      local serverData
      local stationInfo = PlayerData:GetHomeInfo().stations[tostring(info.startStation)]
      if stationInfo ~= nil and stationInfo.quests.Buy ~= nil and stationInfo.quests.Buy[tostring(info.id)] ~= nil then
        serverData = stationInfo.quests.Buy[tostring(info.id)].info
      end
      local curNum = 0
      if serverData ~= nil and type(serverData) == "table" then
        curNum = serverData[tostring(goods.id)] or 0
      end
      element.Group_Item.Txt_Num:SetText(curNum .. "/" .. goods.num)
    end
    element.Group_Item.Img_Send:SetActive(info.isSend)
    element.Group_Item.Img_Specialty:SetActive(info.isBuy and goodsCA.isSpeciality)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_ScrollGrid_Goods_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenGoodsTips(id, 1)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_ScrollGrid_Passenger_SetGrid = function(element, elementIndex)
    local DataModel = require("UIPassenger/UIPassengerDataModel")
    local info = DataModel.orderPassengerList[elementIndex]
    element.Group_Passenger.Img_ClientMask.Img_Client:SetSprite(info.passengerCA.resUrl)
    element.Group_Passenger.Txt_Num:SetText(info.num)
  end,
  HomeCOC_Group_Store_Group_Resources_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeCOC_Group_Store_Group_Furniture_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local idx = tonumber(elementIndex)
    element.Btn_1:SetClickParam(idx)
    local row = HomeStoreDataModel.Now_List.shopList[idx]
    local data = PlayerData:GetFactoryData(row.id)
    element.Txt_Name:SetText(data.commodityName)
    element.Img_Mask.Img_Item:SetSprite(data.commodityView)
    local qualityInt = data.qualityInt
    element.Img_Quality:SetSprite(UIConfig.HomeStoreQuality[qualityInt + 1])
    if data.purchase then
      element.Group_SY.self:SetActive(true)
      local textId = 0
      if data.limitBuyType == "Forever" then
        textId = 80600430
      elseif data.limitBuyType == "Daily" then
        textId = 80600798
      elseif data.limitBuyType == "Weekly" then
        textId = 80600800
      elseif data.limitBuyType == "Monthly" then
        textId = 80600801
      end
      element.Group_SY.Txt_Num:SetText(string.format(GetText(textId), row.residue, data.purchaseNum))
      if row.residue == 0 then
        element.Img_ShouWan.self:SetActive(true)
      else
        element.Img_ShouWan.self:SetActive(false)
      end
    else
      element.Group_SY.self:SetActive(false)
      element.Img_ShouWan.self:SetActive(false)
    end
    local money = data.moneyList[1]
    if money then
      element.Group_Money.self:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
      element.Group_Money.Img_Money:SetSprite(left_money.buyPath)
      element.Group_Money.Txt_MoneyNum:SetText(data.moneyList[1].moneyNum)
    else
      element.Group_Money.self:SetActive(false)
    end
    element.Img_Time.self:SetActive(false)
    local item = data.commodityItemList[1]
    if item then
      local itemCA = PlayerData:GetFactoryData(item.id)
      element.Group_Attribute.Group_AttributePlant.self:SetActive(0 < itemCA.plantScores)
      element.Group_Attribute.Group_AttributePlant.Txt_Scores:SetText(itemCA.plantScores)
      element.Group_Attribute.Group_AttributeFish.self:SetActive(0 < itemCA.fishScores)
      element.Group_Attribute.Group_AttributeFish.Txt_Scores:SetText(itemCA.fishScores)
      element.Group_Attribute.Group_AttributePet.self:SetActive(0 < itemCA.petScores)
      element.Group_Attribute.Group_AttributePet.Txt_Scores:SetText(itemCA.petScores)
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.foodScores)
      element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.foodScores)
      element.Group_Attribute.Group_AttributeComfort.self:SetActive(0 < itemCA.comfort)
      element.Group_Attribute.Group_AttributeComfort.Txt_Scores:SetText(itemCA.comfort)
    end
    element.Img_AllLimit.self:SetActive(false)
    element.Img_AllLimit.Group_1.Txt_Rep:SetActive(false)
    element.Img_AllLimit.Group_1.Txt_Grade:SetActive(false)
    if row.buyLimit then
      if 0 < row.limitRep then
        element.Img_AllLimit.self:SetActive(true)
        element.Img_AllLimit.Group_1.Txt_Rep:SetActive(true)
        element.Img_AllLimit.Group_1.Txt_Rep:SetText(string.format(GetText(80601109), row.limitRep))
      end
      if 0 < row.limitGrade then
        element.Img_AllLimit.self:SetActive(true)
        element.Img_AllLimit.Group_1.Txt_Grade:SetActive(true)
        element.Img_AllLimit.Group_1.Txt_Grade:SetText(string.format(GetText(80601022), row.limitGrade))
      end
    end
  end,
  HomeCOC_Group_Store_Group_Furniture_ScrollGrid_List_Group_Item_Btn_1_Click = function(btn, str)
    local row = HomeStoreDataModel.Now_List.shopList[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    if row.buyLimit then
      CommonTips.OpenTips(80601023)
      return
    end
    row.commoditData = PlayerData:GetFactoryData(row.id)
    row.index = tonumber(str) - 1
    local shopId = HomeStoreDataModel.Now_List.shopId
    row.shopid = shopId
    row.name = row.commoditData.commodityName
    row.image = row.commoditData.commodityView
    row.qualityInt = row.commoditData.qualityInt + 1
    CommonTips.OpenBuyTips(row, function(cnt)
      Controller:RefreshStoreCoin()
      HomeStoreDataModel.Now_List.server = PlayerData.ServerData.shops[tostring(shopId)]
      HomeStoreDataModel.RefreshShopDataDetail()
      View.Group_Store.Group_Furniture.ScrollGrid_List.grid.self:RefreshAllElement()
    end)
  end,
  HomeCOC_Group_Store_Group_StoreTab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    element.Btn_Furniture:SetClickParam(elementIndex)
    element.Btn_Furniture.Group_On.self:SetActive(elementIndex == HomeStoreDataModel.curIndex)
    local shopId = HomeStoreDataModel.List[elementIndex].shopId
    local storeConfig = PlayerData:GetFactoryData(shopId, "StoreFactory")
    element.Btn_Furniture.Group_On.Txt_Name:SetText(storeConfig.storeName)
    element.Btn_Furniture.Group_On.Img_Icon:SetSprite(storeConfig.pngSelect)
    element.Btn_Furniture.Group_Off.Txt_Name:SetText(storeConfig.storeName)
    element.Btn_Furniture.Group_Off.Img_Icon:SetSprite(storeConfig.pngNotSelect)
  end,
  HomeCOC_Group_Store_Group_StoreTab_ScrollGrid_Tab_Group_Item_Btn_Furniture_Click = function(btn, str)
    local idx = tonumber(str)
    HomeStoreDataModel.curIndex = idx
    HomeStoreController:ChooseTab(idx)
    View.Group_Store.Group_StoreTab.ScrollGrid_Tab.grid.self:RefreshAllElement()
  end,
  HomeCOC_Group_Store_Group_Time_Img_1_Btn__Click = function(btn, str)
  end,
  HomeCOC_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local HomeCommon = require("Common/HomeCommon")
    HomeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      HomeCommon.SetReputationElement(View.Group_Reputation, DataModel.StationId)
    end)
  end,
  HomeCOC_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Quest.self.IsActive or View.Group_Store.self.IsActive then
      Controller:ReturnToMain()
      return
    end
    UIManager:GoBack()
  end,
  HomeCOC_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    DataModel.IsHomeReturn = true
    UIManager:GoHome()
  end,
  HomeCOC_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301238}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeCOC_Group_Quest_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_PassengerCapacity_Btn_Icon_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_PassengerCapacity_Btn_Add_Click = function(btn, str)
  end,
  HomeCOC_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_Map_Content_Btn_Close_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_Map_Content_ScrollGrid_Station_SetGrid = function(element, elementIndex)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_Map_Content_ScrollGrid_Station_Group_Item_Btn_S1_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_Group_QuestInfo_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeCOC_Group_Store_Group_Resources_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_Group_Item_Group_Info_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshRewardElement(element, elementIndex)
  end,
  HomeCOC_Group_Quest_ScrollGrid_QuestList_Group_Item_Group_Info_Group_Reward_ScrollGrid_Reward_Group_Reward_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickRewardElement(str)
  end,
  HomeCOC_Group_Main_Btn_Exchange_Click = function(btn, str)
    Controller:ClickOpenExchange()
  end
}
return ViewFunction
