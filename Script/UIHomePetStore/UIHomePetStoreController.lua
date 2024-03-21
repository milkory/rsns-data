local View = require("UIHomePetStore/UIHomePetStoreView")
local DataModel = require("UIHomePetStore/UIHomePetStoreDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

function Controller:Init()
  View.Group_Main.self:SetActive(true)
  View.Group_Store.self:SetActive(false)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Store.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationConfig.name)
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
  NPCDialog.SetNPC(View.Group_NPCPos.Group_NPC, DataModel.NpcId)
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  Controller:RefreshResources()
  Controller:ResetShow()
  Controller:CheckQuestProcess()
end

function Controller:CheckQuestProcess()
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local t = {}
  t.buildingId = DataModel.BuildingId
  status.extraUIParamData = t
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      View.Group_Main.Btn_Talk.Txt_Name:SetText(questCA.name)
    else
    end
  else
    View.Group_Main.Btn_Talk.Txt_Name:SetText(GetText(80602502))
  end
end

function Controller:RefreshResources()
  View.Group_Store.Group_Resources.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
end

function Controller:ReturnToMain()
  View.self:PlayAnim("Main")
  View.Group_Main.self:SetActive(true)
  View.Group_Store.self:SetActive(false)
  DataModel.CurPetSelectedIdx = 0
end

function Controller:ClickTrade()
  Net:SendProto("shop.info", function(json)
    View.self:PlayAnim("Store")
    DataModel.InitShopData()
    Controller:SelectTab(DataModel.TradeType.Buy, DataModel.TabType.Pet, true)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.animalStoreText)
  end)
end

function Controller:SelectTab(tradeType, tabType, force)
  if not force and DataModel.CurTradeType == tradeType and DataModel.CurTabType == tabType then
    return
  end
  local lastTradeType = DataModel.CurTradeType
  local lastTabType = DataModel.CurTabType
  DataModel.CurTradeType = tradeType
  DataModel.CurTabType = tabType
  View.Group_Main.self:SetActive(false)
  View.Group_Store.self:SetActive(true)
  View.Group_Store.Group_Buy.self:SetActive(true)
  if lastTradeType ~= tradeType then
    if tradeType == DataModel.TradeType.Buy then
      View.Group_Store.Img_SellBG:SetActive(false)
      View.Group_Store.Group_Buy.self:SetActive(true)
      View.Group_Store.Group_Sell.self:SetActive(false)
      DOTweenTools.DOLocalMoveXCallback(View.Group_Store.Group_Tab.Img_Selected.transform, -382.5, 0.25, function()
        View.Group_Store.Group_Tab.Btn_Buy.Group_On.self:SetActive(true)
        View.Group_Store.Group_Tab.Btn_Buy.Group_Off.self:SetActive(false)
        View.Group_Store.Group_Tab.Btn_Sell.Group_On.self:SetActive(false)
        View.Group_Store.Group_Tab.Btn_Sell.Group_Off.self:SetActive(true)
      end)
    else
      DataModel.InitCanSaleData()
      View.Group_Store.Img_SellBG:SetActive(true)
      View.Group_Store.Group_Buy.self:SetActive(false)
      View.Group_Store.Group_Sell.self:SetActive(true)
      DOTweenTools.DOLocalMoveXCallback(View.Group_Store.Group_Tab.Img_Selected.transform, -83.5, 0.25, function()
        View.Group_Store.Group_Tab.Btn_Buy.Group_On.self:SetActive(false)
        View.Group_Store.Group_Tab.Btn_Buy.Group_Off.self:SetActive(true)
        View.Group_Store.Group_Tab.Btn_Sell.Group_On.self:SetActive(true)
        View.Group_Store.Group_Tab.Btn_Sell.Group_Off.self:SetActive(false)
      end)
    end
  end
  local element
  if lastTabType ~= DataModel.CurTabType and lastTabType ~= 0 then
    element = View.Group_Store.Group_StoreTab[DataModel.TabBtnName[lastTabType]]
    element.Group_Off.self:SetActive(true)
    element.Group_On.self:SetActive(false)
    element = View.Group_Store.Group_Buy[DataModel.TabBuyDetailName[lastTabType]]
    element.self:SetActive(false)
    element = View.Group_Store.Group_Sell[DataModel.TabSaleDetailName[lastTabType]]
    element.self:SetActive(false)
  end
  if lastTradeType ~= DataModel.CurTradeType then
  end
  element = View.Group_Store.Group_StoreTab[DataModel.TabBtnName[tabType]]
  element.Group_Off.self:SetActive(false)
  element.Group_On.self:SetActive(true)
  Controller:ShowDetailTabSelected(tabType)
end

function Controller:ShowDetailTabSelected(tabType)
  View.Group_Store.Group_Nothing.self:SetActive(false)
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  if isBuy then
    DataModel.Now_List = DataModel.List[tabType]
  else
    DataModel.Now_List = DataModel.CanSaleList[tabType]
  end
  local generalBuyRefresh = function()
    local element = View.Group_Store.Group_Buy[DataModel.TabBuyDetailName[tabType]]
    element.self:SetActive(true)
    element.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    element.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  local generalSaleRefresh = function()
    local element = View.Group_Store.Group_Sell[DataModel.TabSaleDetailName[tabType]]
    element.self:SetActive(true)
    Controller:RefreshSaleScrollGrid()
  end
  if tabType == DataModel.TabType.Pet then
    if isBuy then
      local element = View.Group_Store.Group_Buy[DataModel.TabBuyDetailName[tabType]]
      element.self:SetActive(true)
      Controller:RefreshPetElement()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.petStoreText)
    else
      generalSaleRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.petSellText)
    end
  elseif tabType == DataModel.TabType.Plant then
    if isBuy then
      generalBuyRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.plantStoreText)
    else
      generalSaleRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.plantSellText)
    end
  elseif tabType == DataModel.TabType.Fish then
    if isBuy then
      generalBuyRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.fishStoreText)
    else
      generalSaleRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.fishSellText)
    end
  elseif tabType == DataModel.TabType.PetStuff then
    if isBuy then
      generalBuyRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.petStuffStoreText)
    else
      generalSaleRefresh()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.petStuffSellText)
    end
  end
end

function Controller:RefreshGeneralBuyShow(element, elementIndex)
  local idx = tonumber(elementIndex)
  local row = DataModel.Now_List.shopList[idx]
  element.Btn_1:SetClickParam(idx)
  local data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
  element.Txt_Name:SetText(data.commodityName)
  element.Img_Mask.Img_Item:SetSprite(data.commodityView)
  if DataModel.Now_List.server then
    if DataModel.Now_List.storeType == "Random" or DataModel.Now_List.storeType == "Repeatable" then
      for k, v in pairs(DataModel.Now_List.server.items) do
        if k == idx and tonumber(v.id) == tonumber(row.id) then
          row.py_cnt = v.py_cnt
        end
      end
    else
      for k, v in pairs(DataModel.Now_List.server.items) do
        if tonumber(v.id) == tonumber(row.id) then
          row.py_cnt = v.py_cnt
        end
      end
    end
  end
  local purchase = data.purchase
  if purchase == true then
    row.residue = data.purchaseNum - (row.py_cnt or 0)
    if row.residue < 0 then
      row.residue = 0
    end
    if row.residue == 0 then
      element.Img_ShouWan.self:SetActive(true)
    else
      element.Img_ShouWan.self:SetActive(false)
    end
  else
    row.residue = 100
    element.Img_ShouWan.self:SetActive(false)
  end
  row.storeType = DataModel.Now_List.storeType
  local money = data.moneyList[1]
  if money then
    element.Group_Money.self:SetActive(true)
    local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
    local path = left_money.buyPath
    if path == "" then
      path = left_money.iconPath
    end
    element.Group_Money.Group_Money.Img_Money:SetSprite(path)
    element.Group_Money.Txt_MoneyNum:SetText(data.moneyList[1].moneyNum)
  else
    element.Group_Money.self:SetActive(false)
  end
  local item = data.commodityItemList[1]
  if item then
    local itemCA = PlayerData:GetFactoryData(item.id)
    if itemCA.plantScores then
      element.Group_Attribute.Group_AttributePlant.self:SetActive(0 < itemCA.plantScores)
      element.Group_Attribute.Group_AttributePlant.Txt_Scores:SetText(itemCA.plantScores)
    else
      element.Group_Attribute.Group_AttributePlant.self:SetActive(false)
    end
    if itemCA.fishScores then
      element.Group_Attribute.Group_AttributeFish.self:SetActive(0 < itemCA.fishScores)
      element.Group_Attribute.Group_AttributeFish.Txt_Scores:SetText(itemCA.fishScores)
    else
      element.Group_Attribute.Group_AttributeFish.self:SetActive(false)
    end
    if itemCA.petScores then
      element.Group_Attribute.Group_AttributePet.self:SetActive(0 < itemCA.petScores)
      element.Group_Attribute.Group_AttributePet.Txt_Scores:SetText(itemCA.petScores)
    else
      element.Group_Attribute.Group_AttributePet.self:SetActive(false)
    end
    if itemCA.foodScores then
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.foodScores)
      element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.foodScores)
    else
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(false)
    end
    if itemCA.petFoodNum then
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.petFoodNum)
      element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.petFoodNum)
    else
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(false)
    end
    if itemCA.comfort then
      element.Group_Attribute.Group_AttributeComfort.self:SetActive(0 < itemCA.comfort)
      element.Group_Attribute.Group_AttributeComfort.Txt_Scores:SetText(itemCA.comfort)
    else
      element.Group_Attribute.Group_AttributeComfort.self:SetActive(false)
    end
    if itemCA.dayLove then
      element.Group_Attribute.Group_AttributeLove.self:SetActive(0 < itemCA.dayLove)
      element.Group_Attribute.Group_AttributeLove.Txt_Scores:SetText(string.format(GetText(80601096), itemCA.dayLove))
    else
      element.Group_Attribute.Group_AttributeLove.self:SetActive(false)
    end
    if itemCA.addLove then
      element.Group_Attribute.Group_AttributeLove.self:SetActive(0 < itemCA.addLove)
      element.Group_Attribute.Group_AttributeLove.Txt_Scores:SetText(itemCA.addLove)
    else
      element.Group_Attribute.Group_AttributeLove.self:SetActive(false)
    end
  end
end

function Controller:RefreshPetElement()
  local curTime = TimeUtil:GetServerTimeStamp()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local refreshTime = TimeUtil:GetNextWeekTime(1, h, curTime)
  local remainTime = refreshTime - curTime
  local day = math.modf(remainTime / 86400)
  remainTime = remainTime - day * 86400
  local hour = math.modf(remainTime / 3600)
  View.Group_Store.Group_Buy.Group_Pet.Img_PetTime.Txt_:SetText(string.format(GetText(80600954), day, hour))
  for i = 1, 3 do
    local row = DataModel.Now_List.shopList[i]
    local data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
    local element = View.Group_Store.Group_Buy.Group_Pet["Group_Pet" .. i]
    element.Group_Price.self:SetActive(false)
    element.Btn_Pet:SetClickParam(i)
    if DataModel.Now_List.server then
      if DataModel.Now_List.storeType == "Random" or DataModel.Now_List.storeType == "Repeatable" then
        for k, v in pairs(DataModel.Now_List.server.items) do
          if k == i and tonumber(v.id) == tonumber(row.id) then
            row.py_cnt = v.py_cnt
          end
        end
      else
        for k, v in pairs(DataModel.Now_List.server.items) do
          if tonumber(v.id) == tonumber(row.id) then
            row.py_cnt = v.py_cnt
          end
        end
      end
    end
    local purchase = data.purchase
    local isSoldOut = false
    if purchase == true then
      row.residue = data.purchaseNum - (row.py_cnt or 0)
      if row.residue < 0 then
        row.residue = 0
      end
      if row.residue == 0 then
        isSoldOut = true
      end
    else
      row.residue = 100
    end
    element.Img_SoldOut:SetActive(isSoldOut)
    element.Spine_Pet:SetActive(not isSoldOut)
    element.Btn_Pet:SetActive(not isSoldOut)
    row.storeType = DataModel.Now_List.storeType
    local money = data.moneyList[1]
    if money then
      local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
      local path = left_money.buyPath
      if path == "" then
        path = left_money.iconPath
      end
      element.Group_Price.Btn_Money.self:SetClickParam(i)
      element.Group_Price.Btn_Money.Img_MoneyBG.Group_Money.Img_MoneyIcon:SetSprite(path)
      element.Group_Price.Btn_Money.Img_MoneyBG.Txt_Price:SetText(data.moneyList[1].moneyNum)
    end
    local item = data.commodityItemList[1]
    if not isSoldOut and item then
      local itemDataCA = PlayerData:GetFactoryData(item.id)
      local itemCA = PlayerData:GetFactoryData(itemDataCA.homeCharacter, "PetFactory")
      element.Spine_Pet:SetData(itemCA.resDir, itemCA.rest)
      if 0 < itemDataCA.petVarity then
        local iconPath = PlayerData:GetFactoryData(itemDataCA.petVarity).petVarityIcon
        element.Group_Price.Group_Name.Img_TypeIcon:SetSprite(iconPath)
      end
      element.Group_Price.Group_Name.Txt_Name:SetText(itemDataCA.petName)
      element.Group_Price.Group_Attribute1.Txt_Scores:SetText("+" .. itemDataCA.petBaseScore)
      element.Group_Price.Group_Attribute2.Txt_Scores:SetText(string.format(GetText(80600742), itemDataCA.petFoodInt))
    end
  end
end

function Controller:RefreshPlantElement(element, elementIndex)
  Controller:RefreshGeneralBuyShow(element, elementIndex)
  local idx = tonumber(elementIndex)
  local row = DataModel.Now_List.shopList[idx]
  local data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
  local item = data.commodityItemList[1]
  if item then
    local itemCA = PlayerData:GetFactoryData(item.id)
    element.Img_Item:SetSprite(itemCA.iconPath)
    element.Group_AttributeComfort.Txt_Scores:SetText(itemCA.plantScores)
    element.Group_Attribute.Txt_Scores:SetText(itemCA.comfort)
  end
end

function Controller:RefreshPetStuffElement(element, elementIndex)
  Controller:RefreshGeneralBuyShow(element, elementIndex)
  local idx = tonumber(elementIndex)
  local row = DataModel.Now_List.shopList[idx]
  local data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
  local item = data.commodityItemList[1]
  if item then
    local itemCA = PlayerData:GetFactoryData(item.id)
    element.Img_Item:SetSprite(itemCA.iconPath)
    element.Group_Atrribute.Group_AttributePlant.self:SetActive(itemCA.plantScores > 0)
    element.Group_Atrribute.Group_AttributePlant.Txt_Scores:SetText(itemCA.plantScores)
    element.Group_Atrribute.Group_AttributeFish.self:SetActive(0 < itemCA.fishScores)
    element.Group_Atrribute.Group_AttributeFish.Txt_Scores:SetText(itemCA.fishScores)
    element.Group_Atrribute.Group_AttributePet.self:SetActive(0 < itemCA.petScores)
    element.Group_Atrribute.Group_AttributePet.Txt_Scores:SetText(itemCA.petScores)
    element.Group_Atrribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.foodScores)
    element.Group_Atrribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.foodScores)
    element.Group_Atrribute.Group_AttributeComfort.self:SetActive(0 < itemCA.comfort)
    element.Group_Atrribute.Group_AttributeComfort.Txt_Scores:SetText(itemCA.comfort)
  end
end

function Controller:ClickPetItem(idx)
  local curElement = View.Group_Store.Group_Buy.Group_Pet["Group_Pet" .. idx]
  local row = DataModel.Now_List.shopList[idx]
  local data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
  local item = data.commodityItemList[1]
  local itemDataCA = PlayerData:GetFactoryData(item.id)
  local itemCA = PlayerData:GetFactoryData(itemDataCA.homeCharacter, "PetFactory")
  if DataModel.CurPetSelectedIdx == idx then
    curElement.self:SelectPlayAnim("PetBubbleClose1")
    curElement.Spine_Pet:SetAction(itemCA.rest, true, true)
    DataModel.CurPetSelectedIdx = 0
  elseif DataModel.CurPetSelectedIdx > 0 then
    curElement.Group_Price.self:SetActive(true)
    curElement.self:SelectPlayAnim("PetBubbleOpen1")
    curElement.Spine_Pet:SetAction(itemCA.stand, true, true)
    local lastElement = View.Group_Store.Group_Buy.Group_Pet["Group_Pet" .. DataModel.CurPetSelectedIdx]
    lastElement.self:SelectPlayAnim("PetBubbleClose1")
    row = DataModel.Now_List.shopList[DataModel.CurPetSelectedIdx]
    data = PlayerData:GetFactoryData(row.id, "CommodityFactory")
    item = data.commodityItemList[1]
    itemDataCA = PlayerData:GetFactoryData(item.id)
    itemCA = PlayerData:GetFactoryData(itemDataCA.homeCharacter, "PetFactory")
    lastElement.Spine_Pet:SetAction(itemCA.rest, true, true)
    DataModel.CurPetSelectedIdx = idx
  else
    curElement.Group_Price.self:SetActive(true)
    curElement.self:SelectPlayAnim("PetBubbleOpen1")
    curElement.Spine_Pet:SetAction(itemCA.stand, true, true)
    DataModel.CurPetSelectedIdx = idx
  end
end

function Controller:ConfirmBuyPet(idx)
  local row = DataModel.Now_List.shopList[idx]
  row.commoditData = PlayerData:GetFactoryData(row.id)
  row.index = idx - 1
  row.shopid = DataModel.Now_List.shopId
  row.name = row.commoditData.commodityName
  row.image = row.commoditData.commodityView
  row.qualityInt = row.commoditData.qualityInt + 1
  row.noShowReward = true
  local uIdRecord = {}
  for k, v in pairs(PlayerData:GetHomePet()) do
    uIdRecord[k] = 0
  end
  CommonTips.OpenBuyTips(row, function(cnt)
    Controller:RefreshResources()
    DataModel.Now_List.server = PlayerData.ServerData.shops[tostring(DataModel.Now_List.shopId)]
    DataModel.CurPetSelectedIdx = 0
    Controller:RefreshPetElement()
    View.Img_BG:SetSprite(DataModel.BgPath)
    View.Img_BG:SetColor(DataModel.BgColor)
    local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    View.Group_Store.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationConfig.name)
    View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
    NPCDialog.SetNPC(View.Group_NPCPos.Group_NPC, DataModel.NpcId)
    Controller:RefreshResources()
    for k, v in pairs(PlayerData:GetHomePet()) do
      if uIdRecord[k] == nil then
        DataModel.BuyPetUId = k
        break
      end
    end
    UIManager:Open("UI/HomePetStore/PetAcquire", Json.encode({
      uid = DataModel.BuyPetUId
    }))
    DataModel.CanSaleList = {}
  end)
end

function Controller:GeneralBuyClickItem(str)
  local idx = tonumber(str)
  local row = DataModel.Now_List.shopList[idx]
  if row.residue == 0 then
    CommonTips.OpenTips(80600077)
    return
  end
  row.commoditData = PlayerData:GetFactoryData(row.id)
  row.index = idx - 1
  row.shopid = DataModel.Now_List.shopId
  row.name = row.commoditData.commodityName
  row.image = row.commoditData.commodityView
  row.qualityInt = row.commoditData.qualityInt + 1
  CommonTips.OpenBuyTips(row, function(cnt)
    Controller:RefreshResources()
    DataModel.Now_List.server = PlayerData.ServerData.shops[tostring(DataModel.Now_List.shopId)]
    View.Group_Store.Group_Buy.Group_General.ScrollGrid_List.grid.self:RefreshAllElement()
    DataModel.CanSaleList = {}
  end)
end

function Controller:RefreshGeneralSaleShow(element, elementIndex)
  local info = DataModel.Now_List.commodityList[elementIndex]
  local commodityCA = PlayerData:GetFactoryData(info.commodityId, "CommodityFactory")
  element.Group_Level.self:SetActive(DataModel.CurTabType == DataModel.TabType.Pet)
  element.Group_SY.self:SetActive(DataModel.CurTabType ~= DataModel.TabType.Pet)
  element.Btn_1:SetClickParam(elementIndex)
  local moneyList = commodityCA.recycleMoneyList
  element.Group_Money.Txt_MoneyNum:SetText(moneyList[1].moneyNum)
  element.Img_Mask.Img_Item:SetSprite(commodityCA.commodityView)
  if DataModel.CurTabType == DataModel.TabType.Pet then
    local name = info.data.name
    if name == "" then
      name = commodityCA.commodityName
    end
    element.Txt_Name:SetText(name)
    element.Group_Level.Group_Num.Txt_Num:SetText(info.data.lv)
  else
    element.Txt_Name:SetText(commodityCA.commodityName)
    element.Group_SY.Img_1.Txt_Num:SetText(info.num)
  end
  local itemCA = PlayerData:GetFactoryData(info.id)
  if itemCA.plantScores then
    element.Group_Attribute.Group_AttributePlant.self:SetActive(itemCA.plantScores > 0)
    element.Group_Attribute.Group_AttributePlant.Txt_Scores:SetText(itemCA.plantScores)
  else
    element.Group_Attribute.Group_AttributePlant.self:SetActive(false)
  end
  if itemCA.fishScores then
    element.Group_Attribute.Group_AttributeFish.self:SetActive(0 < itemCA.fishScores)
    element.Group_Attribute.Group_AttributeFish.Txt_Scores:SetText(itemCA.fishScores)
  else
    element.Group_Attribute.Group_AttributeFish.self:SetActive(false)
  end
  if info.data.scores then
    element.Group_Attribute.Group_AttributePet.self:SetActive(0 < info.data.scores)
    element.Group_Attribute.Group_AttributePet.Txt_Scores:SetText(info.data.scores)
  else
    element.Group_Attribute.Group_AttributePet.self:SetActive(false)
  end
  if itemCA.foodScores then
    element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.foodScores)
    element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.foodScores)
  else
    element.Group_Attribute.Group_AttributeAppetite.self:SetActive(false)
  end
  if itemCA.petFoodNum then
    element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.petFoodNum)
    element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.petFoodNum)
  else
    element.Group_Attribute.Group_AttributeAppetite.self:SetActive(false)
  end
  if itemCA.comfort then
    element.Group_Attribute.Group_AttributeComfort.self:SetActive(0 < itemCA.comfort)
    element.Group_Attribute.Group_AttributeComfort.Txt_Scores:SetText(itemCA.comfort)
  else
    element.Group_Attribute.Group_AttributeComfort.self:SetActive(false)
  end
  if itemCA.dayLove then
    element.Group_Attribute.Group_AttributeLove.self:SetActive(0 < itemCA.dayLove)
    element.Group_Attribute.Group_AttributeLove.Txt_Scores:SetText(string.format(GetText(80601096), itemCA.dayLove))
  else
    element.Group_Attribute.Group_AttributeLove.self:SetActive(false)
  end
  if itemCA.addLove then
    element.Group_Attribute.Group_AttributeLove.self:SetActive(0 < itemCA.addLove)
    element.Group_Attribute.Group_AttributeLove.Txt_Scores:SetText(itemCA.addLove)
  else
    element.Group_Attribute.Group_AttributeLove.self:SetActive(false)
  end
end

function Controller:GeneralSaleClickItem(str)
  local idx = tonumber(str)
  local info = DataModel.Now_List.commodityList[idx]
  info.shopId = DataModel.Now_List.shopId
  CommonTips.OpenShopSaleTips(info, function()
    Controller:RefreshResources()
    DataModel.RefreshSpecialTypeData(DataModel.CurTabType)
    DataModel.Now_List = DataModel.CanSaleList[DataModel.CurTabType]
    Controller:RefreshSaleScrollGrid()
  end)
end

function Controller:RefreshSaleScrollGrid()
  local count = table.count(DataModel.Now_List.commodityList)
  local showSale = 0 < count
  View.Group_Store.Group_Sell.self:SetActive(showSale)
  View.Group_Store.Group_Nothing.self:SetActive(not showSale)
  if showSale then
    local element = View.Group_Store.Group_Sell[DataModel.TabSaleDetailName[DataModel.CurTabType]]
    element.ScrollGrid_List.grid.self:SetDataCount(count)
    element.ScrollGrid_List.grid.self:RefreshAllElement()
  end
end

function Controller:ResetShow()
  for k, v in pairs(DataModel.TabBtnName) do
    local element = View.Group_Store.Group_StoreTab[v]
    element.Group_Off.self:SetActive(true)
    element.Group_On.self:SetActive(false)
  end
  for k, v in pairs(DataModel.TabBuyDetailName) do
    local element = View.Group_Store.Group_Buy[v]
    element.self:SetActive(false)
  end
end

function Controller:ShowNPCTalk(dialogEnum)
  if dialogEnum == DataModel.NPCDialogEnum.talkText and QuestProcess.CheckTalkDo(DataModel.CacheEventList, View, DataModel.BuildingId, function()
    View.Group_Main:SetActive(true)
  end) then
    View.Group_Main:SetActive(false)
    return
  end
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPCPos.Group_NPC, textTable, dialogEnum)
end

return Controller
