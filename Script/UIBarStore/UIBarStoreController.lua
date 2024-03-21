local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

function Controller:Init()
  View.Group_Main.self:SetActive(true)
  View.Group_Main.Btn_Drink.self:SetActive(true)
  View.Group_Main.Btn_Store.self:SetActive(true)
  View.Group_Main.Btn_Talk.self:SetActive(true)
  View.Group_Main.Group_Drink.self:SetActive(false)
  View.Group_LocalStore.self:SetActive(false)
  View.Img_Backgroud:SetSprite(DataModel.BgPath)
  View.Img_Backgroud:SetColor(DataModel.BgColor)
  Controller:InitNPC()
  Controller:CheckQuestProcess()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
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
      View.Group_Main.Btn_Talk.Txt_:SetText(questCA.name)
    else
    end
  else
    View.Group_Main.Btn_Talk.Txt_:SetText(GetText(80602502))
  end
end

function Controller:OpenDrink()
  Controller:CheckTimeDrinkCountRefresh()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local useCount = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num or 0
  if useCount >= stationCA.limitNum then
    if 0 < stationCA.recoverItem then
      local t = {}
      t.itemId = stationCA.recoverItem
      t.useNum = 1
      local itemCA = PlayerData:GetFactoryData(t.itemId)
      CommonTips.OnItemPrompt(string.format(GetText(80601345), itemCA.name), t, function()
        if PlayerData:GetGoodsById(t.itemId).num < t.useNum then
          CommonTips.OpenTips(80600062)
          return
        end
        Net:SendProto("station.replenish", function()
          local use = {}
          use[t.itemId] = t.useNum
          PlayerData:RefreshUseItems(use)
          PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num = useCount - 1
          CommonTips.OpenTips(80601363)
        end)
      end)
    else
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.upperText)
    end
    return
  end
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.OneText)
  View.Group_Main.Btn_Drink.self:SetActive(false)
  View.Group_Main.Btn_Store.self:SetActive(false)
  View.Group_Main.Btn_Talk.self:SetActive(false)
  View.Group_Main.Group_Drink.self:SetActive(true)
  Controller:RefreshDrinkInfo()
  View.self:PlayAnim("Drink_In")
end

function Controller:CheckTimeDrinkCountRefresh()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  if PlayerData.TempCache.drinkRefresh == nil then
    PlayerData.TempCache.drinkRefresh = PlayerData.ServerData.login_time
  end
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s, PlayerData.TempCache.drinkRefresh)
  if targetTime <= TimeUtil:GetServerTimeStamp() then
    PlayerData.TempCache.drinkRefresh = TimeUtil:GetServerTimeStamp()
    PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num = 0
    return true
  end
  return false
end

function Controller:OpenStore()
  DataModel.CacheOpenStore = {}
  DataModel.List = {}
  DataModel.AutoRefreshTime = {}
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.StoreText)
  DataModel.CurIndex = 1
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_LocalStore")
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_LocalStore.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetReputationElement(View.Group_LocalStore.Group_Reputation, DataModel.StationId)
  Controller:ChooseTab(1, true)
  Controller:RefreshResource()
  View.self:PlayAnim("StoreList")
end

function Controller:DrinkReturnToMain()
  View.Group_Main.Btn_Drink.self:SetActive(true)
  View.Group_Main.Btn_Store.self:SetActive(true)
  View.Group_Main.Btn_Talk.self:SetActive(true)
  View.Group_Main.Group_Drink.self:SetActive(false)
  View.self:PlayAnim("Drink_Out")
end

function Controller:StoreReturnToMain()
  View.Group_LocalStore.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.self:PlayAnim("Main")
end

function Controller:RefreshTopTab(idx)
  local isSelect = DataModel.CurIndex == idx
  local element
  if idx == 1 then
    element = View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Headquarters
  else
    element = View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Local
  end
  element.Group_Off:SetActive(not isSelect)
  element.Group_On:SetActive(isSelect)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local isShow = idx <= table.count(stationConfig.barStoreList)
  element.self:SetActive(isShow)
  if isShow then
    local shopId = stationConfig.barStoreList[idx].id
    local storeConfig = PlayerData:GetFactoryData(shopId, "StoreFactory")
    element.Group_On.Txt_Name:SetText(storeConfig.storeName)
    element.Group_On.Img_Select:SetSprite(storeConfig.pngSelect)
    element.Group_Off.Txt_Name:SetText(storeConfig.storeName)
    element.Group_Off.Img_Select:SetSprite(storeConfig.pngNotSelect)
  end
end

function Controller:ChooseTab(idx, notAni)
  local detailDo = function()
    View.Group_LocalStore.self:SetActive(true)
    DataModel.CurIndex = idx
    Controller:RefreshTopTab(1)
    Controller:RefreshTopTab(2)
    DataModel.Now_List = DataModel.List[idx]
    DataModel.ShopId = DataModel.Now_List.shopId
    DataModel.RefreshShopDataDetail()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:MoveToTop()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
    local storeFactory = PlayerData:GetFactoryData(DataModel.Now_List.shopId, "StoreFactory")
    local isShow = #storeFactory.moneyList > 0
    View.Group_LocalStore.Group_StoreList.Btn_ShuaXin.self:SetActive(isShow)
    local isAutoRefresh = storeFactory.autoRefresh
    View.Group_LocalStore.Group_StoreList.Group_Time.self:SetActive(isAutoRefresh)
    if isAutoRefresh then
      local time = storeFactory.refreshTimeList[1]
      local h = tonumber(string.sub(time.refreshTime, 1, 2))
      local m = tonumber(string.sub(time.refreshTime, 4, 5))
      local textId
      if storeFactory.refreshType == "Daily" then
        textId = 80600463
      elseif storeFactory.refreshType == "Weekly" then
        textId = 80600786
      elseif storeFactory.refreshType == "Monthly" then
        textId = 80600787
      end
      View.Group_LocalStore.Group_StoreList.Group_Time.Txt_Time:SetText(string.format(GetText(textId), h, m))
    end
    if not notAni then
      View.self:PlayAnimOnce("Switch")
    end
  end
  if DataModel.CacheOpenStore[idx] == nil then
    local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    local storeId = stationConfig.barStoreList[idx].id
    Net:SendProto("shop.info", function(json)
      DataModel.CacheOpenStore[idx] = 0
      DataModel.InitShopData(idx)
      detailDo()
    end, storeId)
  else
    detailDo()
  end
end

function Controller:RefreshResource()
  View.Group_LocalStore.Group_Ding.Btn_YN.Txt_Num:SetText(DataModel.GetYN())
  View.Group_LocalStore.Group_Ding.Btn_HS.Txt_Num:SetText(DataModel.GetHS())
  View.Group_LocalStore.Group_Ding.Btn_LV.Txt_Num:SetText(DataModel.GetCharacterCoin())
end

function Controller:RefreshShop()
  local storeFactory = PlayerData:GetFactoryData(DataModel.Now_List.shopId, "StoreFactory")
  local isShow = #storeFactory.moneyList > 0
  if isShow then
    local info = storeFactory.moneyList[1]
    local t = {}
    t.itemId = info.moneyID
    t.useNum = info.moneyNum
    local itemCA = PlayerData:GetFactoryData(t.itemId, "ItemFactory")
    CommonTips.OnItemPrompt(string.format(GetText(80600586), itemCA.name), t, function()
      Net:SendProto("shop.refresh", function()
        DataModel.InitShopData(DataModel.CurIndex)
        Controller:ChooseTab(DataModel.CurIndex)
        local use = {}
        use[t.itemId] = t.useNum
        PlayerData:RefreshUseItems(use)
      end, DataModel.ShopId)
      Controller:RefreshResource()
    end)
  end
end

function Controller:RefreshCommodityShow(element, elementIndex)
  local idx = tonumber(elementIndex)
  element.Group_Item.Btn_Item:SetClickParam(idx)
  local row = DataModel.Now_List.shopList[idx]
  local data = PlayerData:GetFactoryData(row.id)
  element.Group_Item.Btn_Item.Img_ItemRole.self:SetActive(false)
  element.Group_Item.Btn_Item.Txt_ItemName:SetText(data.commodityName)
  element.Group_Item.Btn_Item.Img_ItemBG.Img_Item:SetSprite(data.commodityView)
  element.Group_Item.Btn_Item.Img_ItemBG.Txt_Num:SetText(data.commodityNum)
  local qualityInt = data.qualityInt
  element.Group_Item.Btn_Item.Img_ItemBG.self:SetSprite(UIConfig.BottomConfig[qualityInt + 1])
  element.Group_Item.Btn_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[qualityInt + 1])
  if data.purchase then
    element.Group_Item.Btn_Item.Img_ItemBG.Img_Residue:SetActive(true)
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum:SetActive(true)
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
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum.Txt_ResidueNum:SetText(string.format(GetText(textId), row.residue, data.purchaseNum))
    if row.residue == 0 then
      element.Group_Item.Btn_Item.Img_Sold.self:SetActive(true)
    else
      element.Group_Item.Btn_Item.Img_Sold.self:SetActive(false)
    end
  else
    element.Group_Item.Btn_Item.Img_ItemBG.Img_Residue:SetActive(false)
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum:SetActive(false)
    element.Group_Item.Btn_Item.Img_Sold.self:SetActive(false)
  end
  element.Group_Item.Btn_Item.Group_Discount.self:SetActive(0 < data.discountVariable)
  if 0 < data.discountVariable then
    element.Group_Item.Btn_Item.Group_Discount.Txt_Discount:SetText(string.format(GetText(80601651), data.discountVariable))
  end
  local money = data.moneyList[1]
  if money then
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(true)
    local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
    local path = left_money.buyPath
    if path == "" then
      path = left_money.iconPath
    end
    element.Group_Item.Btn_Item.Group_Money.Img_Money:SetSprite(path)
    local moneyNum = data.moneyList[1].moneyNum
    if data.isChange and 0 < data.moneyList[1].correspondPrice then
      local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
      local buyCount = (row.py_cnt or 0) + 1
      local priceCount = #listCA.priceList
      if buyCount > priceCount then
        buyCount = priceCount
      end
      moneyNum = listCA.priceList[buyCount].num
    end
    element.Group_Item.Btn_Item.Group_Money.Txt_MoneyNum:SetText(moneyNum)
  else
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(false)
  end
  local commodity = data.commodityItemList[1]
  local factoryName = DataManager:GetFactoryNameById(commodity.id)
  if factoryName == "EquipmentFactory" then
    local detailData = PlayerData:GetFactoryData(commodity.id)
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.self:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", detailData.equipTagId)
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[detailData.qualityInt])
  else
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.self:SetActive(false)
  end
  element.Group_Item.Btn_Item.Img_Limit.self:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(false)
  if row.buyLimit then
    if 0 < row.limitRep then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetText(string.format(GetText(80601109), row.limitRep))
    end
    if 0 < row.limitGrade then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetText(string.format(GetText(80601022), row.limitGrade))
    end
  end
  element.Group_Item.Btn_Item.Group_Time.self:SetActive(false)
  if data.isTriggerTime and row.endTime then
    local remainTime = row.endTime - TimeUtil:GetServerTimeStamp()
    element.Group_Item.Btn_Item.Group_Time.self:SetActive(0 < remainTime)
    if 0 < remainTime then
      local day = math.modf(remainTime / 86400)
      remainTime = remainTime - day * 86400
      local hour = math.ceil(remainTime / 3600)
      if hour == 24 then
        hour = 23
      elseif hour == 0 then
        hour = 23
        day = day - 1
      end
      element.Group_Item.Btn_Item.Group_Time.Txt_Time:SetText(string.format(GetText(80600954), day, hour))
    end
  end
end

function Controller:RefreshDrinkInfo()
  local homeCommon = require("Common/HomeCommon")
  local maxTired = homeCommon.GetMaxHomeEnergy()
  local curTired = PlayerData:GetUserInfo().move_energy
  View.Group_Main.Group_Drink.Group_Energy.Txt_Num:SetText(curTired .. "/" .. maxTired)
  View.Group_Main.Group_Drink.Group_Energy.Img_PB:SetFilledImgAmount(curTired / maxTired)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.DrinkInfo = stationConfig.drinkCost
  DataModel.DrinkCurCount = (PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num or 0) + 1
  View.Group_Main.Group_Drink.StaticGrid_Drink.grid.self:RefreshAllElement()
end

function Controller:Drink(idx)
  Controller:CheckTimeDrinkCountRefresh()
  DataModel.DrinkIdx = idx
  local info = DataModel.DrinkInfo[idx]
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local useCount = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num or 0
  if useCount >= stationConfig.limitNum then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.upperText)
    CommonTips.OpenTips(80600462)
    Controller:DrinkReturnToMain()
    return
  end
  if 0 < PlayerData:GetHomeInfo().free_drink then
    local listCA = PlayerData:GetFactoryData(info.id, "ListFactory")
    local select = DataModel.DrinkCurCount
    if select > #listCA.drinkList then
      select = #listCA.drinkList
    end
    local costInfo = listCA.drinkList[select]
    if PlayerData:GetGoodsById(costInfo.id).num < costInfo.num then
      local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
      local t = {
        [1] = itemCA.name
      }
      NPCDialog.HandleNPCTxtSpecialTable(DataModel.NPCDialogEnum.ItemText, t)
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.ItemText)
      return
    end
  end
  local detailDo = function()
    if Controller:CheckShowDrinkBuffReplace() then
      return
    end
    Controller:ConfirmDrink()
  end
  local curMoveEnergy = PlayerData:GetUserInfo().move_energy
  if curMoveEnergy == 0 then
    CommonTips.OnPrompt(80600957, nil, nil, function()
      detailDo()
    end)
  else
    detailDo()
  end
end

function Controller:ConfirmDrink()
  local oldMoveEnergy = PlayerData:GetUserInfo().move_energy
  Net:SendProto("station.drink", function(json)
    if PlayerData:GetHomeInfo().free_drink == 0 then
      PlayerData:GetHomeInfo().free_drink = 1
    end
    local recoverEnergy = oldMoveEnergy - PlayerData:GetUserInfo().move_energy
    PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num + 1
    Controller:RefreshDrinkInfo()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.drinkText)
    local buffId = 0
    if json.home_skills ~= nil then
      local serverData = PlayerData.ServerData.home_skills
      local drinkBuff = PlayerData:GetCurDrinkBuff()
      if drinkBuff ~= nil then
        local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
        if serverData[buffCA.buffType] ~= nil then
          serverData[buffCA.buffType].temp = nil
        end
      end
      for k, v in pairs(json.home_skills) do
        if serverData[k] == nil then
          serverData[k] = {}
        end
        serverData[k].temp = v.temp
        local t = {}
        for k1, v1 in pairs(v.temp) do
          if v1.obtain == "drink" then
            buffId = k1
            t.id = k1
            for k2, v2 in pairs(v1) do
              t[k2] = v2
            end
            break
          end
        end
        PlayerData:SetDrinkBuff(t)
        break
      end
    end
    local isShowVideo = Controller:ShowVideo(function()
      Controller:ShowDrinkBuff(buffId, recoverEnergy)
    end)
    if not isShowVideo then
      Controller:ShowDrinkBuff(buffId, recoverEnergy)
    end
    local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    if PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].drink_num >= stationConfig.limitNum then
      Controller:DrinkReturnToMain()
    end
  end, DataModel.DrinkIdx - 1)
end

function Controller:CheckShowDrinkBuffReplace()
  local checkTime = PlayerData:GetPlayerPrefs("int", "ShowReplaceDrinkBuffTip")
  if checkTime ~= 0 then
    local recordDay = TimeUtil:GetTimeStampTotalDays(checkTime)
    local curTime = TimeUtil:GetServerTimeStamp()
    local curTotalDay = TimeUtil:GetTimeStampTotalDays(curTime)
    if recordDay == curTotalDay then
      return false
    end
    PlayerData:SetPlayerPrefs("int", "ShowReplaceDrinkBuffTip", 0)
  end
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  if drinkBuff ~= nil then
    UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_TishiWindow")
    View.Group_TishiWindow.self:SetActive(true)
    local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
    local oneForAll = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.OneForAll)
    local desc = buffCA.desc
    if 0 < oneForAll then
      desc = buffCA.intensifyDesc
    end
    View.Group_TishiWindow.Group_1.Txt_Dec:SetText(desc)
    local min = (drinkBuff.endTime - TimeUtil:GetServerTimeStamp()) / 60
    View.Group_TishiWindow.Group_1.Txt_Time:SetText(string.format(GetText(80600773), math.ceil(min)))
    return true
  end
  return false
end

function Controller:ConfirmReplaceBuff()
  if View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive then
    PlayerData:SetPlayerPrefs("int", "ShowReplaceDrinkBuffTip", TimeUtil:GetServerTimeStamp())
  end
  Controller:ConfirmDrink()
  View.Group_TishiWindow.self:SetActive(false)
end

function Controller:ShowDrinkBuff(buffId, recoverEnergy)
  if buffId == 0 then
    return
  end
  local t = {}
  t.buffId = buffId
  t.recoverEnergy = recoverEnergy
  UIManager:Open("UI/Home/BarStore/DrinkBuff", Json.encode(t))
end

function Controller:TimeAutoRefresh()
  local curTime = TimeUtil:GetServerTimeStamp()
  for k1, v1 in pairs(DataModel.AutoRefreshTime) do
    if v1 < curTime then
      DataModel.AutoRefreshTime[k1] = v1 + 86400
      Net:SendProto("shop.info", function(json)
        DataModel.InitShopData(DataModel.CurIndex)
        if View.Group_LocalStore and View.Group_LocalStore.self and View.Group_LocalStore.self.IsActive then
          Controller:ChooseTab(DataModel.CurIndex)
        end
      end)
      break
    end
  end
end

function Controller:ShowVideo(cb)
  View.Video_Drink.self:SetActive(true)
  View.Img_IpadTop:SetActive(true)
  View.Img_IpadBtm:SetActive(true)
  View.Btn_Skip.self:SetActive(true)
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Video_Drink.self:Play(stationCA.drinkVideo, false, false, true, function()
    cb()
    View.Img_IpadTop:SetActive(false)
    View.Img_IpadBtm:SetActive(false)
    View.Group_Skip.self:SetActive(false)
    View.Btn_Skip.self:SetActive(false)
  end)
  return true
end

function Controller:VideoSkip()
  if View.Group_Skip.self ~= nil and View.Group_Skip.self.IsActive and View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self.IsActive then
    PlayerData:SetPlayerPrefs("int", "ShowDrinkVideo", TimeUtil:GetServerTimeStamp())
  end
  View.Group_Skip.self:SetActive(false)
  View.Video_Drink.self:VideoOver()
  View.Video_Drink.self:SetActive(false)
end

function Controller:CloseSkip()
  View.Group_Skip.self:SetActive(false)
end

function Controller:InitNPC()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
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
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

return Controller
