local View = require("UIHomeCOC/UIHomeCOCView")
local DataModel = require("UIHomeCOC/UIHomeCOCDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local HomeStoreDataModel = require("UIHomeCOC/UIHomeCOCStoreDataModel")
local HomeStoreController = require("UIHomeCOC/UIHomeCOCStoreController")
local NPCDialog = require("Common/NPCDialog")
local CommonBtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  View.Group_Main.self:SetActive(true)
  View.Group_Quest.self:SetActive(false)
  View.Group_Store.self:SetActive(false)
  View.Group_NpcInfo.self:SetActive(false)
  View.Group_Reputation.self:SetActive(false)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor("#" .. DataModel.BgColor)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  HomeCommon.SetReputationElement(View.Group_Reputation, DataModel.StationId)
  self:RefreshBtnExchange()
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

function Controller:BackInit()
  View.Group_Quest.self:SetActive(false)
  View.Group_Store.self:SetActive(false)
  View.Group_Main:SetActive(true)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor("#" .. DataModel.BgColor)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationConfig.name)
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  HomeCommon.SetReputationElement(View.Group_Reputation, DataModel.StationId)
  self:RefreshBtnExchange()
  Controller:CheckQuestProcess()
end

function Controller:ReturnToMain()
  View.Group_Main.self:SetActive(true)
  View.Group_Quest.self:SetActive(false)
  View.Group_Store.self:SetActive(false)
  View.Group_NpcInfo.self:SetActive(false)
  View.Group_Reputation.self:SetActive(false)
  self:RefreshBtnExchange()
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  View.self:PlayAnim("Main")
end

function Controller:RefreshBtnExchange()
  local isExchangeLock = PlayerData:GetUserInfo().lv < (DataModel.ExchangeLevelLimt or 0)
  View.Group_Main.Btn_Exchange.Img_Limit.self:SetActive(isExchangeLock)
  if isExchangeLock then
    View.Group_Main.Btn_Exchange.Img_Limit.Group_Limit.Txt_Limit:SetText(string.format(GetText(80601914), DataModel.ExchangeLevelLimt or 0))
  end
end

function Controller:ClickOpenExchange()
  if PlayerData:GetUserInfo().lv < (DataModel.ExchangeLevelLimt or 0) then
    return
  end
  if DataModel.ExchangeId == nil or 0 >= DataModel.ExchangeId then
    return
  end
  local buildingCA = PlayerData:GetFactoryData(DataModel.ExchangeId, "BuildingFactory")
  local storeList = buildingCA.exchangeStoreList
  local storeId, remainTime, isOpen
  for i = 1, #storeList do
    isOpen, remainTime = PlayerData:IsStoreOpen(storeList[i].id)
    if isOpen then
      storeId = storeList[i].id
      break
    end
  end
  if not isOpen then
    return
  end
  Net:SendProto("shop.info", function(json)
    UIManager:Open(buildingCA.uiPath, Json.encode({
      buildingId = DataModel.ExchangeId,
      isCityMapIn = false,
      name = buildingCA.name,
      stationId = DataModel.StationId,
      bgPath = DataModel.BgPath,
      npcId = DataModel.NpcId,
      initMode = "Exchange",
      helpId = 80301238
    }))
    PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
  end, storeId)
end

function Controller:ClickQuestTab(noMoveTop)
  Net:SendProto("quest.list", function(json)
    PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].quests = json.quests.station_quests
    View.Group_Main.self:SetActive(false)
    View.Group_NpcInfo.self:SetActive(true)
    View.Group_Reputation.self:SetActive(true)
    View.self:PlayAnim("QuestList")
    Controller:RefreshOrderPanel(json.quests.station_quests, noMoveTop)
  end, EnumDefine.QuestListDefine.SomeOneStationQuest, DataModel.StationId)
end

function Controller:DayRefreshOrderPanel()
  if TimeUtil:GetServerTimeStamp() > DataModel.NextRefreshTime then
    DataModel.InitDayRefreshTime()
    Net:SendProto("quest.list", function(json)
      PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].quests = json.quests.station_quests
      Controller:RefreshOrderPanel(json.quests.station_quests)
      CommonTips.OpenTips(80600492)
    end, EnumDefine.QuestListDefine.SomeOneStationQuest, DataModel.StationId)
  end
end

function Controller:RefreshOrderPanel(quests, noMoveTop)
  DataModel.InitDayRefreshTime()
  DataModel.RefreshAllOrderInfo(quests)
  Controller:RefreshTopShow()
  View.Group_Quest.self:SetActive(true)
  if not noMoveTop then
    View.Group_Quest.ScrollGrid_QuestList.grid.self:MoveToTop()
  end
  local isNull = true
  if quests == nil then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.questListNullText)
    View.Group_Quest.ScrollGrid_QuestList.grid.self:SetDataCount(1)
    View.Group_Quest.ScrollGrid_QuestList.grid.self:RefreshAllElement()
    return
  end
  local questsCount = #DataModel.OrderInfo
  local isNull = questsCount == 0
  local homeCommon = require("Common/HomeCommon")
  local curRepConfigData = homeCommon.GetCurLvRepData(DataModel.StationId)
  View.Group_Quest.Group_QuestNum.Txt_Num:SetText(questsCount .. "/" .. curRepConfigData.cocAutoRefreshNum)
  View.Group_Quest.ScrollGrid_QuestList.grid.self:SetDataCount(questsCount + 1)
  View.Group_Quest.ScrollGrid_QuestList.grid.self:RefreshAllElement()
  if not isNull then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.questListText)
  else
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.questListNullText)
  end
  View.Group_Quest.Group_QuestInfo.self:SetActive(false)
end

function Controller:SelectOrder(idx)
  local isRemoveData = Controller:TimeLimitRemoveData()
  if isRemoveData then
    return
  end
  View.Group_Quest.Group_QuestInfo.Btn_Prev:SetActive(idx ~= 1)
  View.Group_Quest.Group_QuestInfo.Btn_Next:SetActive(idx ~= table.count(DataModel.OrderInfo))
  DataModel.CurSelectedOrderIdx = idx
  local info = DataModel.OrderInfo[idx]
  local stationConfig = PlayerData:GetFactoryData(info.endStation, "HomeStationFactory")
  View.Group_Quest.Group_QuestInfo.self:SetActive(true)
  View.Group_Quest.Group_QuestInfo.Txt_Title:SetText(info.name)
  if info.type == "Send" or info.type == "Buy" then
    View.Group_Quest.Group_QuestInfo.ScrollView_Describe.Viewport.Txt_Describe:SetText(string.format(info.detail, stationConfig.name))
  else
    View.Group_Quest.Group_QuestInfo.ScrollView_Describe.Viewport.Txt_Describe:SetText(info.detail)
  end
  View.Group_Quest.Group_QuestInfo.Img_ClientMask.Img_Client:SetSprite(info.clientIcon)
  View.Group_Quest.Group_QuestInfo.Txt_Client:SetText(string.format(GetText(80600674), info.clientName))
  View.Group_Quest.Group_QuestInfo.Img_Passenger:SetActive(info.isPassenger)
  View.Group_Quest.Group_QuestInfo.ScrollGrid_Passenger.self:SetActive(info.isPassenger)
  View.Group_Quest.Group_QuestInfo.Img_Space:SetActive(not info.isPassenger)
  View.Group_Quest.Group_QuestInfo.ScrollGrid_Goods.self:SetActive(not info.isPassenger)
  if info.isPassenger then
    local DataModel = require("UIPassenger/UIPassengerDataModel")
    DataModel.RefreshOrderPassengerList(info)
    View.Group_Quest.Group_QuestInfo.ScrollGrid_Passenger.grid.self:SetDataCount(#DataModel.orderPassengerList)
    if #DataModel.orderPassengerList ~= 0 then
      View.Group_Quest.Group_QuestInfo.ScrollGrid_Passenger.grid.self:RefreshAllElement()
    end
  else
    local goodsList = info.goodsList
    View.Group_Quest.Group_QuestInfo.ScrollGrid_Goods.grid.self:SetDataCount(#goodsList)
    if #goodsList ~= 0 then
      View.Group_Quest.Group_QuestInfo.ScrollGrid_Goods.grid.self:RefreshAllElement()
    end
  end
  local addShow = ""
  local space = 0
  if info.isSend then
    space = info.space
  elseif info.isPassenger then
    space = info.space
  end
  View.Group_Quest.Group_QuestInfo.Txt_Space_Goods:SetActive(not info.isPassenger)
  View.Group_Quest.Group_QuestInfo.Txt_Space_Passenger:SetActive(info.isPassenger)
  local curSpace, maxSpace
  if info.isPassenger then
    curSpace = PlayerData:GetCurPassengerNum()
    maxSpace = PlayerData:GetMaxPassengerNum()
  else
    curSpace = DataModel.CurUseSpace
    maxSpace = DataModel.MaxSpace
  end
  if info.state ~= 0 then
    if space ~= 0 then
      addShow = "-" .. math.ceil(space)
    end
    View.Group_Quest.Group_QuestInfo.Img_PBAfter:SetFilledImgAmount(curSpace / maxSpace)
    View.Group_Quest.Group_QuestInfo.Img_PBNow:SetFilledImgAmount((curSpace - space) / maxSpace)
  else
    if space ~= 0 then
      addShow = "+" .. math.ceil(space)
    end
    View.Group_Quest.Group_QuestInfo.Img_PBAfter:SetFilledImgAmount((curSpace + space) / maxSpace)
    View.Group_Quest.Group_QuestInfo.Img_PBNow:SetFilledImgAmount(curSpace / maxSpace)
  end
  View.Group_Quest.Group_QuestInfo.Txt_Space:SetText(string.format(GetText(80600529), math.ceil(curSpace), addShow, maxSpace))
  View.Group_Quest.Group_QuestInfo.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewards)
  View.Group_Quest.Group_QuestInfo.ScrollGrid_Reward.grid.self:RefreshAllElement()
  local endPos = Vector2(-stationConfig.x, -stationConfig.y)
  local addPos = View.Group_Quest.Group_QuestInfo.Group_Map.Group_Position.self.Rect.anchoredPosition
  View.Group_Quest.Group_QuestInfo.Group_Map.Content:SetAnchoredPosition(endPos + Vector2(addPos.x, addPos.y))
  if 0 < info.configLimitTime then
    View.Group_Quest.Group_QuestInfo.Group_Time:SetActive(true)
    View.Group_Quest.Group_QuestInfo.Group_Time.Txt_Time:SetText(info.showTimeText)
  else
    View.Group_Quest.Group_QuestInfo.Group_Time:SetActive(false)
  end
  local isIng = info.state == 1
  View.Group_Quest.Group_QuestInfo.Btn_Cancel.self:SetActive(isIng)
  View.Group_Quest.Group_QuestInfo.Btn_Receive.self:SetActive(not isIng)
end

function Controller:PattenDetailText(sourceText)
  local text = ""
  local v0, v1, v2, v3, v4
  print_r(CS.System.String.Format("{3} {1} {0}", 2, 1, 3, 4))
  return text
end

function Controller:AddOrder()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local itemInfo = homeConfig.cocAddQuestItemList[1]
  local num = PlayerData:GetGoodsById(itemInfo.id).num
  local params = {}
  params.itemId = itemInfo.id
  params.itemNum = num
  params.useNum = itemInfo.num
  local itemCA = PlayerData:GetFactoryData(itemInfo.id, "ItemFactory")
  CommonTips.OnItemPrompt(string.format(GetText(80600495), itemCA.name), params, function()
    if num < itemInfo.num then
      CommonTips.OpenTips(80600488)
      return
    end
    Net:SendProto("station.add_quest", function(json)
      local t = {}
      t[itemInfo.id] = itemInfo.num
      PlayerData:RefreshUseItems(t)
      PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].quests = json.quests
      Controller:RefreshOrderPanel(json.quests)
      View.Group_Quest.ScrollGrid_QuestList.self:SelectPlayAnim("RefreshList")
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.addQuestSuccessText)
    end)
  end)
end

function Controller:ReceiveOrder(info)
  local cb = function()
    Controller:RefreshTopShow()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.acceptQuestText)
    View.Group_Quest.ScrollGrid_QuestList.grid.self:MoveToTop()
    View.Group_Quest.ScrollGrid_QuestList.grid.self:RefreshAllElement()
    View.Group_Quest.Group_QuestInfo.self:SetActive(false)
    View.Group_Quest.ScrollGrid_QuestList.self:SelectPlayAnim("RefreshList")
  end
  DataModel.ReceiveOrder(info, cb)
end

function Controller:CancelOrder(info)
  local cb = function()
    Controller:RefreshTopShow()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.cancelQuestText)
    View.Group_Quest.ScrollGrid_QuestList.grid.self:MoveToTop()
    View.Group_Quest.ScrollGrid_QuestList.grid.self:SetDataCount(#DataModel.OrderInfo + 1)
    View.Group_Quest.ScrollGrid_QuestList.grid.self:RefreshAllElement()
    View.Group_Quest.Group_QuestInfo.self:SetActive(false)
    CommonTips.OpenTips(80600486)
    View.Group_Quest.ScrollGrid_QuestList.self:SelectPlayAnim("RefreshList")
  end
  DataModel.CancelOrder(info, cb)
end

function Controller:CompleteOrder(info)
  local cb = function()
  end
  DataModel.CompleteOrder(info, cb)
end

function Controller:RefreshTopShow()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetLoadageElement(View.Group_Quest.Group_Loadage)
  homeCommon.SetPassengerElement(View.Group_Quest.Group_PassengerCapacity)
end

function Controller:RefreshRewardElement(element, elementIndex)
  local index = tonumber(element.ParentParam)
  local info = DataModel.OrderInfo[index]
  local rewardInfo = info.rewards[elementIndex]
  CommonBtnItem:SetItem(element.Group_Item, {
    id = rewardInfo.id,
    num = rewardInfo.num
  })
  element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
end

function Controller:ClickRewardElement(str)
  local id = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(id)
end

function Controller:ClickStoreTab()
  Net:SendProto("shop.info", function(json)
    Controller:RefreshStoreCoin()
    View.Group_Main.self:SetActive(false)
    View.Group_NpcInfo.self:SetActive(true)
    View.Group_Reputation.self:SetActive(true)
    View.Group_Store.self:SetActive(true)
    HomeStoreController.InitStore()
    HomeStoreDataModel.curIndex = 1
    HomeStoreController:ChooseTab(HomeStoreDataModel.curIndex)
    View.self:PlayAnim("StoreList")
  end)
end

function Controller:RefreshStoreCoin()
  View.Group_Store.Group_Resources.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
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

function Controller:TimeLimitRemoveData()
  local isRefresh = false
  local curTime = TimeUtil:GetServerTimeStamp()
  local count = #DataModel.OrderInfo
  local newOrder = {}
  for i = 1, count do
    local info = DataModel.OrderInfo[i]
    if info.configLimitTime > 0 then
      if 0 >= info.limitTime or curTime < info.limitTime then
        table.insert(newOrder, info)
      else
        isRefresh = true
      end
    else
      table.insert(newOrder, info)
    end
  end
  if not isRefresh then
    return false
  end
  DataModel.OrderInfo = newOrder
  local questsCount = #DataModel.OrderInfo
  local isNull = questsCount == 0
  if not isNull then
    View.Group_Quest.ScrollGrid_QuestList.grid.self:SetDataCount(questsCount)
  else
    View.Group_Quest.ScrollGrid_QuestList.grid.self:SetDataCount(questsCount + 1)
  end
  local homeCommon = require("Common/HomeCommon")
  local curRepConfigData = homeCommon.GetCurLvRepData(DataModel.StationId)
  View.Group_Quest.Group_QuestNum.Txt_Num:SetText(questsCount .. "/" .. curRepConfigData.cocAutoRefreshNum)
  View.Group_Quest.ScrollGrid_QuestList.grid.self:RefreshAllElement()
  View.Group_Quest.Group_QuestInfo.self:SetActive(false)
  CommonTips.OpenTips(80600476)
  return true
end

return Controller
