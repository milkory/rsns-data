local View = require("UIHomeBattleCenter/UIHomeBattleCenterView")
local DataModel = {
  StationId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
  levels = {},
  refreshChecked = false,
  DayRefreshTime = 0,
  CurStationRepLv = 0,
  NPCDialogEnum = {
    talkText = "talkText",
    enterText = "enterText",
    tabOrderText = "tabOrderText",
    tabBattleText = "tabBattleText",
    orderSuccessText = "orderSuccessText",
    notEnoughText = "notEnoughText",
    signText = "signText",
    cancelSignText = "cancelSignText",
    discardText = "discardText",
    enterExchangeText = "enterExchangeText",
    enterSaleText = "enterSaleText",
    exchangeSuccessText = "exchangeSuccessText",
    saleSuccessText = "saleSuccessText"
  }
}
local npcId = 0
local defaultHeight = 102
local NPCDiagGroupEnum = {Mutex = "Mutex", Order = "Order"}
local dialogGroup = {
  belongName = "",
  listId = 0,
  curIdx = 0
}
local setNpcText = function(element, txt)
  element.Img_Dialog.self:SetActive(true)
  element.Img_Dialog.Txt_Talk:SetText(txt)
  local height = element.Img_Dialog.Txt_Talk:GetHeight()
  element.Img_Dialog.Txt_Talk:SetHeight(height)
  element.Img_Dialog.self:SetHeight(defaultHeight + height)
  element.Img_Dialog.Txt_Talk:SetTweenContent(txt)
end
local getDetailText = function(info)
  local text = info.detailTxt
  if text == nil then
    text = GetTextNPCMod(info.id)
  end
  return text
end

function DataModel:SetNPCSpine(element, id)
  npcId = id
  local npcConfig = PlayerData:GetFactoryData(id, "NPCFactory")
  element.self:SetActive(true)
  if npcConfig.spineUrl ~= "" then
    element.SpineAnimation_Character:SetActive(true)
    element.Img_Role:SetActive(false)
    element.SpineAnimation_Character:SetData(npcConfig.spineUrl)
    local offset = Vector2(npcConfig.spineOffsetX, npcConfig.spineOffsetY)
    element.SpineAnimation_Character:SetAnchoredPosition(offset)
    if npcConfig.spineScale ~= nil then
      element.SpineAnimation_Character:SetLocalScale(Vector3(npcConfig.spineScale * 100, npcConfig.spineScale * 100, npcConfig.spineScale))
    end
  else
    element.SpineAnimation_Character:SetActive(false)
    element.Img_Role:SetActive(true)
    element.Img_Role:SetSprite(npcConfig.resUrl)
    local offset = Vector2(npcConfig.offsetX, npcConfig.offsetY)
    element.Img_Role:SetAnchoredPosition(offset)
  end
  element.Img_Name.Txt_Name:SetText(npcConfig.name)
  dialogGroup.belongName = ""
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
end

function DataModel:HandleNPCTxtTable(extraValue)
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  local curReputationLv = 0
  if extraValue ~= nil then
    curReputationLv = extraValue.repLv or 0
  end
  for k, v in pairs(npcConfig) do
    if type(v) == "table" then
      for k1, v1 in pairs(v) do
        local factoryName = DataManager:GetFactoryNameById(v1.id)
        if factoryName == "ListFactory" then
          local listCA = PlayerData:GetFactoryData(v1.id, factoryName)
          if listCA.listType == NPCDiagGroupEnum.Mutex then
            local dialogList = listCA.dialogList
            for i = 1, #dialogList - 1 do
              local cur = dialogList[i]
              local next = dialogList[i + 1]
              cur.detailTxt = nil
              cur.isHide = true
              if curReputationLv <= next.reputation then
                cur.isHide = false
              else
                next.isHide = false
              end
            end
          end
        else
          v1.detailTxt = nil
          v1.isHide = nil
        end
      end
    end
  end
end

function DataModel:HandleNPCTxtSpecialTable(enum, extraValue)
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  if npcConfig[enum] ~= nil then
    local t = npcConfig[enum]
    if enum == "ItemText" then
      local value = extraValue[1]
      for k, v in pairs(t) do
        v.detailTxt = string.format(GetText(v.id), value)
      end
    end
  end
end

function DataModel:SetNPCText(element, txtTable, tableName)
  if txtTable == nil or #txtTable <= 0 then
    return
  end
  if dialogGroup.belongName == tableName and dialogGroup.listId ~= 0 then
    local listCA = PlayerData:GetFactoryData(dialogGroup.listId, "ListFactory")
    local dialogList = listCA.dialogList
    if #dialogList > dialogGroup.curIdx then
      dialogGroup.curIdx = dialogGroup.curIdx + 1
      local info = dialogList[dialogGroup.curIdx]
      local text = getDetailText(info)
      setNpcText(element, text)
      return
    end
  end
  dialogGroup.belongName = tableName
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
  local totalWeight = 0
  for k, v in pairs(txtTable) do
    if not v.isHide then
      totalWeight = totalWeight + v.weight
    end
  end
  local randomWeight = math.random(1, totalWeight)
  local detailTxt = ""
  for k, v in pairs(txtTable) do
    if not v.isHide then
      randomWeight = randomWeight - v.weight
      if randomWeight <= 0 then
        local factoryName = DataManager:GetFactoryNameById(v.id)
        if factoryName == "ListFactory" then
          do
            local listCA = PlayerData:GetFactoryData(v.id, factoryName)
            local dialogList = listCA.dialogList
            if listCA.listType == NPCDiagGroupEnum.Mutex then
              for k1, v1 in pairs(dialogList) do
                if not v1.isHide then
                  detailTxt = getDetailText(v1)
                  break
                end
              end
              break
            end
            if listCA.listType == NPCDiagGroupEnum.Order then
              dialogGroup.listId = v.id
              dialogGroup.curIdx = 1
              local info = dialogList[dialogGroup.curIdx]
              detailTxt = getDetailText(info)
            end
          end
          break
        end
        detailTxt = getDetailText(v)
        break
      end
    end
  end
  if detailTxt == "" then
    element.Img_Dialog.self:SetActive(false)
    return
  end
  setNpcText(element, detailTxt)
end

function DataModel:SetNPCTextOne(element, txt)
  local text = txt
  if type(txt) == "number" then
    if txt <= 0 then
      element.Img_Dialog.self:SetActive(false)
      return
    end
    text = GetText(txt)
  end
  setNpcText(element, text)
end

function DataModel:SetNPC()
  DataModel:SetNPCSpine(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  DataModel.HandleNPCTxtTable({repLv = repLv})
end

function DataModel:ShowNPCTalk(dialogEnum)
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  DataModel:SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function DataModel:Init(first)
  View.timer:Start()
  if first then
    View.self:PlayAnim("Main")
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
    View.Group_Main.self:SetActive(true)
    View.Group_Battle.self:SetActive(false)
    View.Group_Order.self:SetActive(false)
    View.Group_Ticket.self:SetActive(false)
    View.Group_Zhu.self:SetActive(false)
    View.Group_Exchange:SetActive(false)
    View.Group_Sale:SetActive(false)
  end
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.StationCA = stationCA
  View.Group_Main.Btn_Battle.Txt_:SetText(stationCA.battleTabName)
  View.Group_Main.Btn_Order.Txt_:SetText(stationCA.orderTabName)
  DataModel:SetNPC()
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  DataModel.battleLevelList = DataModel.StationCA.battleLevelList
  View.Group_Main.StaticGrid_List.grid.self:SetDataCount(#DataModel.StationCA.openPageList)
  View.Group_Main.StaticGrid_List.grid.self:RefreshAllElement()
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  View.Group_Main.Group_NpcInfo.Txt_Name:SetText(DataModel.StationName)
  View.Group_Main.Group_NpcInfo.Img_Icon:SetSprite(DataModel.StationCA.buildingIconPath)
  Net:SendProto("station.construction_info", function()
    DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
    DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
    DataModel:RefreshLeftData(first)
  end)
  local highRecyclableMap = {}
  local recyclableList = PlayerData:GetHomeInfo().recyclable[tostring(stationCA.id)].recyclable
  for i = 1, #recyclableList do
    highRecyclableMap[recyclableList[i]] = true
  end
  table.sort(recyclableList, function(e1, e2)
    local ca1 = PlayerData:GetFactoryData(e1)
    local ca2 = PlayerData:GetFactoryData(e2)
    if ca1.qualityInt ~= ca2.qualityInt then
      return ca1.qualityInt > ca2.qualityInt
    else
      return e1 < e2
    end
  end)
  DataModel.recyclableList = recyclableList
  DataModel.highRecyclableMap = highRecyclableMap
end

function DataModel:RefreshResource(showType)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local maxEnergy = PlayerData:GetUserInfo().max_energy or initConfig.energyMax
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Battle")
  View.Group_Battle.Group_Ding.Btn_Energy.Txt_Num:SetText(PlayerData:GetGoodsById(11400006).num .. "/" .. maxEnergy)
end

DataModel.difficultyBg = {
  [1] = "UI/HomeBattleCenter/easy",
  [2] = "UI/HomeBattleCenter/normal",
  [3] = "UI/HomeBattleCenter/difficult"
}

function DataModel:ChooseBattleLevel(index)
  if DataModel.Index_Battle and index and DataModel.Index_Battle == index then
    return
  end
  if DataModel.Index_Battle and DataModel.ShowBattleLevelList[DataModel.Index_Battle] then
    DataModel.ShowBattleLevelList[DataModel.Index_Battle].element.Img_Select:SetActive(false)
  end
  local row = DataModel.ShowBattleLevelList[index]
  local element = row.element
  element.Img_Select:SetActive(true)
  local Group_Information = View.Group_Battle.Group_1.Group_Information
  Group_Information.Txt_Name:SetText(row.ca.levelName)
  Group_Information.Txt_Dec:SetText(row.ca.description)
  local firstPassAward = row.ca.firstPassAward
  local dropListNew = PlayerData:GetLevelDropList(row.ca)
  local state = PlayerData:GetLevelPass(row.id)
  DataModel.ChooseRewardList = {}
  for i = 1, 20 do
    if firstPassAward[i] then
      table.insert(DataModel.ChooseRewardList, {
        num = firstPassAward[i].num,
        id = firstPassAward[i].itemId,
        type = 1,
        isFinish = state,
        index = #DataModel.ChooseRewardList
      })
    end
    if dropListNew[i] then
      table.insert(DataModel.ChooseRewardList, {
        num = dropListNew[i].num,
        id = dropListNew[i].id,
        type = 2,
        index = #DataModel.ChooseRewardList
      })
    end
  end
  if state == true then
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type > b.type
    end)
  else
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type < b.type
    end)
  end
  Group_Information.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.ChooseRewardList)
  Group_Information.ScrollGrid_Reward.grid.self:RefreshAllElement()
  Group_Information.ScrollGrid_Reward.grid.self:MoveToTop()
  local level = PlayerData:GetUserInfo().lv
  if not row.ca.isEnemyLvEquilsPlayer then
    level = row.ca.recomGrade
  end
  Group_Information.Img_Tuijian.Txt_Grade:SetText(level)
  Group_Information.Group_TZ.Txt_Cost:SetText(row.ca.energyEnd)
  Group_Information.Group_TZ.self:SetActive(row.isBattle)
  Group_Information.Group_Limit.self:SetActive(not row.isBattle)
  DataModel.Index_Battle = index
end

function DataModel:OpenBattlePage()
  DataModel.Index_OutSide = 1
  DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.tabBattleText)
  DataModel.Index_Battle = nil
  DataModel.Index_Init = nil
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Battle")
  View.Group_Battle.self:SetActive(true)
  View.Group_Zhu.self:SetActive(true)
  View.self:PlayAnim("Battle")
  local user_info = PlayerData:GetUserInfo()
  View.Group_Battle.Group_Ding.Btn_Energy.Txt_Num:SetText(user_info.energy .. "/" .. user_info.max_energy or 0)
  DataModel.ShowBattleLevelList = {}
  local count = 1
  for k, v in pairs(DataModel.battleLevelList) do
    local ca = PlayerData:GetFactoryData(v.id)
    if ca.constructLimit <= PlayerData:GetConstructionProportion(DataModel.StationId) then
      DataModel.ShowBattleLevelList[count] = Clone(v)
      count = count + 1
    end
  end
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:SetDataCount(#DataModel.ShowBattleLevelList)
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Battle.Group_1.Group_Top.Txt_Name:SetText(DataModel.StationCA.battleLevelName)
  View.Group_Battle.Group_1.Group_Top.Img_Icon:SetSprite(DataModel.StationCA.battleIconPath)
  if DataModel.Index_Init == nil then
    DataModel.Index_Init = 1
  end
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:MoveToPos(DataModel.Index_Init)
  DataModel:ChooseBattleLevel(DataModel.Index_Init)
  DataModel:RefreshResource(1)
end

function DataModel:ClickOrderListQuestInfo(index)
  local row = DataModel.orderList[tonumber(DataModel.Index_Order)].config.requireItemList[index]
  if row == nil then
    return
  end
  CommonTips.OpenPreRewardDetailTips(row.id, nil, true)
end

function DataModel:ChooseOrder(index)
  if DataModel.Index_Order and index and DataModel.Index_Order == index then
    return
  end
  if DataModel.Index_Order and DataModel.orderList[DataModel.Index_Order] then
    local old_element = DataModel.orderList[DataModel.Index_Order].element
    old_element.Group_On:SetActive(false)
  end
  local row = DataModel.orderList[index]
  local element = row.element
  local Group_Reward = View.Group_Order.Group_1.Group_Dec.Group_Reward
  Group_Reward.Btn_Delivery:SetActive(false)
  Group_Reward.Btn_QuestSign:SetActive(false)
  Group_Reward.Btn_NotDelivery:SetActive(false)
  Group_Reward.Btn_NotQuestSign:SetActive(false)
  Group_Reward.Btn_Exchange:SetActive(true)
  element.Group_On:SetActive(true)
  if row.isSubmit == true then
    element.Group_Submit:SetActive(true)
    Group_Reward.Btn_Delivery:SetActive(true)
  elseif row.is_mark == false then
    Group_Reward.Btn_QuestSign:SetActive(true)
  else
    Group_Reward.Btn_NotQuestSign:SetActive(true)
  end
  local Group_Dec = View.Group_Order.Group_1.Group_Dec
  DataModel.ChooseBattleRewardList = row.config.rewardsList
  Group_Dec.ScrollGrid_Reward.self:SetActive(true)
  Group_Dec.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.ChooseBattleRewardList)
  Group_Dec.ScrollGrid_Reward.grid.self:RefreshAllElement()
  Group_Dec.ScrollGrid_Reward.grid.self:MoveToTop()
  DataModel.Index_Order = index
end

function DataModel:DeleteOreder()
  if DataModel.Index_Order == nil then
    CommonTips.OpenTips("")
    return
  end
  DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.discardText)
  local row = DataModel.orderList[DataModel.Index_Order]
  Net:SendProto("station.refresh_order", function(Json)
    DataModel.StationList.orders = Json.change_order
    if Json.construction then
      DataModel.StationList.construction = Json.construction
    end
    DataModel:OpenOrderPage(1)
    DataModel:RefreshLeftData()
    QuestTrace.CancelQuest(row.oid)
  end, DataModel.Index_Order - 1)
end

function DataModel:OpenOrderPage(state)
  if not state then
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.tabOrderText)
  end
  DataModel.Index_OutSide = 2
  DataModel.Index_Order = nil
  View.Group_Main.self:SetActive(false)
  View.Group_Battle.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Order")
  View.Group_Order.self:SetActive(true)
  View.Group_Zhu.self:SetActive(true)
  View.self:PlayAnim("Order")
  local user_info = PlayerData:GetUserInfo()
  View.Group_Order.Group_Ding.Btn_YN.Txt_Num:SetText(user_info.gold)
  DataModel.orderList = {}
  DataModel.isAllRefreshCount = 0
  local count = 0
  for k, v in pairs(DataModel.StationList.orders) do
    print_r(v)
    local refresh_time = v.refresh_time
    if v.is_unlock == 1 and v.refresh_time == -1 then
      if count == 0 then
        count = k
      else
        count = math.min(k, count)
      end
    end
    if v.refresh_time ~= -1 then
      refresh_time = v.refresh_time + DataModel.StationCA.refreshTime
      if 0 >= refresh_time - TimeUtil:GetServerTimeStamp() then
        if count == 0 then
          count = k
        else
          count = math.min(k, count)
        end
      end
      print_r(v.refresh_time, refresh_time)
    end
    table.insert(DataModel.orderList, {
      oid = v.oid,
      refresh_time = refresh_time,
      is_unlock = v.is_unlock,
      ca = DataModel.StationCA.createOrderList[k],
      is_mark = v.is_mark ~= nil and true or false
    })
  end
  print_r(DataModel.orderList)
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:SetDataCount(#DataModel.orderList)
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:MoveToTop()
  if count ~= 0 then
    View.Group_Order.Group_1.ScrollGrid_List.grid.self:MoveToPos(count)
    DataModel:ChooseOrder(count)
  end
  if DataModel.isAllRefreshCount == 0 then
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_Exchange:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_Delivery:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_QuestSign:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_NotDelivery:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_NotQuestSign:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.ScrollGrid_Reward.self:SetActive(false)
    return
  end
  DataModel:RefreshResource(2)
end

DataModel.park = {
  current_reward = 0,
  maxTicket = 0,
  ticket = 0,
  psg_num = 0,
  total_reward = 0,
  divide = 0,
  record = {},
  maxProfitMonthIndex = 1,
  investmentNum = 0,
  pond = {},
  tax = 0,
  gold = 0
}

function DataModel:GetMaxTicket()
  return self.StationCA.parkTicketMax + self.StationCA.parkTicket
end

function DataModel:JudgeParkDataLimit()
  local maxTicket = self:GetMaxTicket()
  if maxTicket < self.park.ticket then
    self.park.ticket = maxTicket
  end
  if self.park.divide > self.StationCA.maxDivide then
    self.park.divide = self.StationCA.maxDivide
  end
  if self.park.tax < 0 then
    self.park.tax = 0
  end
end

function DataModel:RefreshParkDivide(divide)
  self.park.divide = divide > self.StationCA.maxDivide and self.StationCA.maxDivide or divide
end

function DataModel:RefreshParkInfo(json)
  if json then
    if json.current_reward then
      self.park.current_reward = json.current_reward
    end
    if json.psg_num then
      self.park.psg_num = json.psg_num
    end
    if json.earnings then
      self.park.total_reward = json.earnings
    end
    if json.divide then
      self.park.divide = json.divide
    end
    if json.add then
      self.park.ticket = self.StationCA.parkTicket
      for i, v in pairs(json.add) do
        self.park.ticket = self.park.ticket + v
      end
    end
    if json.record then
      self.park.record = json.record
      local maxProfit = 0
      for i, v in ipairs(json.record) do
        if v > maxProfit then
          maxProfit = v
          self.park.maxProfitMonthIndex = i
        end
      end
    end
    if json.donate_num then
      self.park.investmentNum = json.donate_num
    end
    if json.pond then
      self.park.pond = json.pond
    end
    if json.tax then
      self.park.tax = json.tax
    end
    if json.gold then
      self.park.gold = json.gold
    end
  end
  self:JudgeParkDataLimit()
end

function DataModel:DonateRefreshParkInfo(pondCfg)
  self.park.investmentNum = self.park.investmentNum - 1
  self.park.tax = self.park.tax + pondCfg.tax
  self.park.divide = self.park.divide + pondCfg.divide
  self.park.ticket = self.park.ticket + pondCfg.ticket
  self:JudgeParkDataLimit()
  local stationFairyLand = PlayerData:GetHomeInfo().stations[tostring(self.StationId)].fairyland
  stationFairyLand.donate_num = self.park.investmentNum
  stationFairyLand.tax = self.park.tax
  stationFairyLand.divide = self.park.divide
  stationFairyLand.add.donate = stationFairyLand.add.donate + pondCfg.ticket
  for i, v in ipairs(pondCfg.item) do
    if v.id == 11400001 then
      self.park.gold = self.park.gold + v.num
    end
  end
  stationFairyLand.gold = self.park.gold
end

function DataModel:OpenTicketPage()
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Ticket")
  View.Group_Ticket.self:SetActive(true)
  View.Group_Ticket.Group_StageReward:SetActive(false)
  View.Group_Ticket.Group_CommonTopLeft:SetActive(true)
  self.curStage = self.StationCA.constructStageList[DataModel.Index_Construct]
  self:RefreshBySelectType(1)
  DataModel.park.maxTicket = self:GetMaxTicket()
end

DataModel.curSelectType = 1

function DataModel:RefreshBySelectType(type)
  if self.curSelectType ~= type then
    View.Group_Ticket.Group_StageReward:SetActive(false)
  end
  self.curSelectType = type
  View.Group_Zhu.self:SetActive(true)
  self:RefreshLeftData()
  self:ShowTicketProfit(type == 1)
  self:ShowInvestment(type == 2)
  View.Group_Ticket.Group_TapBattle.GroupGold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
end

DataModel.ticketPriceTexts = {
  80601637,
  80601638,
  80601639,
  8060140,
  8060141
}

function DataModel:ShowTicketProfit(state)
  View.Group_Ticket.Group_TicketProfit:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_TicketProfit.Btn_on:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_TicketProfit.Btn_off:SetActive(not state)
  if state and self.curStage then
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_today.Img_jinbi.Txt_num:SetText(self.park.ticket)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_nextday.Img_jinbi.Txt_num:SetText(self.StationCA.added)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_tax.Txt_num:SetText(ClearFollowZero((self.park.tax < 0 and 0 or self.park.tax) * 100) .. "%")
    local curDay = PlayerData:GetFactoryData(self.StationId, "HomeStationFactory").travelDay
    View.Group_Ticket.Group_TicketProfit.Group_title.Img_fate.Txt_num1:SetText(math.floor(curDay / 10))
    View.Group_Ticket.Group_TicketProfit.Group_title.Img_fate.Txt_num2:SetText(curDay % 10)
    View.Group_Ticket.Group_TicketProfit.Group_title.Group_Psg.Txt_day:SetText(string.format("游客数量：%d", self.park.psg_num))
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_money:SetText(self.park.total_reward)
    local baseDivide = self.StationCA.divide
    local maxDivide = self.StationCA.maxDivide
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_maximum.Txt_:SetText(string.format("最大值%.0f%%", maxDivide * 100))
    View.Group_Ticket.Group_TicketProfit.Group_information.Img_divide.Txt_num:SetText(ClearFollowZero(self.park.divide * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_original.Txt_num:SetText(ClearFollowZero(baseDivide * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Txt_num:SetText(ClearFollowZero((self.park.divide - baseDivide) * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_original.Img_original:SetFilledImgAmount(baseDivide / maxDivide)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Img_added:SetFilledImgAmount((self.park.divide - baseDivide) / maxDivide)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Img_added.transform.localRotation = Quaternion.Euler(0, 0, 360 * baseDivide / maxDivide)
    local base = self.curStage.basisNum
    local over = self.curStage.overNum
    local upper = self.curStage.upperNum
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_num1:SetText(base)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_num2:SetText(over)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic1.Img_decide:SetActive(over > self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk1:SetActive(over > self.park.total_reward)
    local textCA = PlayerData:GetFactoryData(80601644, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk1:SetText(textCA.text)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic2.Img_decide:SetActive(over <= self.park.total_reward and upper > self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk2:SetActive(over <= self.park.total_reward and upper > self.park.total_reward)
    textCA = PlayerData:GetFactoryData(80601636, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk2:SetText(textCA.text)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic3.Img_decide:SetActive(upper <= self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk3:SetActive(upper <= self.park.total_reward)
    textCA = PlayerData:GetFactoryData(80601646, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk3:SetText(textCA.text)
    local baseX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Img_needle1.Rect.anchoredPosition.x
    local overX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Img_needle2.Rect.anchoredPosition.x
    local curX = 0
    local totalX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Rect.rect.width
    if base > self.park.total_reward then
      curX = self.park.total_reward / base * baseX
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    elseif base <= self.park.total_reward and over > self.park.total_reward then
      curX = baseX + (self.park.total_reward - base) / (over - base) * (overX - baseX)
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    elseif over <= self.park.total_reward and upper > self.park.total_reward then
      curX = overX + (self.park.total_reward - over) / (upper - over) * (totalX - overX)
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    else
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(1)
    end
    View.Group_Ticket.Group_TicketProfit.Img_ticketprofit.Group_profit.Txt_money:SetText(self.park.current_reward)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Group_Incomedata.Group_PriceShow.ScrollGrid_LIst.grid.self:SetDataCount(table.count(self.park.record))
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Group_Incomedata.Group_PriceShow.ScrollGrid_LIst.grid.self:RefreshAllElement()
  end
end

DataModel.donateRewardItemObjList = nil

function DataModel:ShowInvestment(state)
  DataModel.donateRewardItemObjList = DataModel.donateRewardItemObjList or {}
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  View.Group_Ticket.Group_Investment:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_Investment.Btn_on:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_Investment.Btn_off:SetActive(not state)
  if not state then
    return
  end
  local stationCA = PlayerData:GetFactoryData(self.StationId, "HomeStationFactory")
  View.Group_Ticket.Group_Investment.Group_information.Group_grossInvestment.Txt_num:SetText(self.park.gold)
  View.Group_Ticket.Group_Investment.Group_information.Group_divide.Txt_num:SetText(ClearFollowZero((self.park.divide - stationCA.divide) * 100) .. "%")
  local tax = 0
  if self.park.tax >= stationCA.tax then
    tax = self.park.tax - stationCA.tax
  else
    tax = math.abs(self.park.tax - stationCA.tax) > stationCA.tax and -stationCA.tax or self.park.tax - stationCA.tax
  end
  View.Group_Ticket.Group_Investment.Group_information.Group_tax.Txt_num:SetText(ClearFollowZero(tax * 100) .. "%")
  View.Group_Ticket.Group_Investment.Group_information.Group_ticket.Txt_num:SetText(self.park.ticket - stationCA.parkTicket)
  View.Group_Ticket.Group_Investment.Img_investmenticon.Txt_investmentTime:SetText(string.format("剩余投资次数:%d", self.park.investmentNum))
  View.Group_Ticket.Group_Investment.ScrollGrid_List.grid.self:SetDataCount(table.count(self.park.pond))
  View.Group_Ticket.Group_Investment.ScrollGrid_List.grid.self:RefreshAllElement()
end

function DataModel.IsInvestTipsShow(pondId)
  local time = PlayerData:GetPlayerPrefs("int", "ParkInvest")
  if time == 0 or time < PlayerData:GetSeverTime() then
    local pondCfg = PlayerData:GetFactoryData(pondId, "PondFactory")
    local addConstructNum = 0
    if pondCfg.build and pondCfg.build[1] then
      addConstructNum = pondCfg.build[1].num
    end
    local constructMax = addConstructNum ~= 0 and PlayerData:GetConstructionProportion(DataModel.StationId) >= DataModel.curStage.constructNum
    if constructMax then
      return 80602598
    end
    local ticketMax = pondCfg.ticket ~= 0 and DataModel.park.ticket >= DataModel.park.maxTicket
    if ticketMax then
      return 80602599
    end
    local taxMax = pondCfg.tax ~= 0 and 0 >= DataModel.park.tax
    if taxMax then
      return 80602600
    end
    local divideMax = pondCfg.divide ~= 0 and DataModel.park.divide >= DataModel.StationCA.maxDivide
    if divideMax then
      return 80602601
    end
  end
  return 0
end

function DataModel.IsInvestTipsShow(pondId)
  local time = PlayerData:GetPlayerPrefs("int", "ParkInvest")
  if time == 0 or time < PlayerData:GetSeverTime() then
    local pondCfg = PlayerData:GetFactoryData(pondId, "PondFactory")
    local addConstructNum = 0
    if pondCfg.build and pondCfg.build[1] then
      addConstructNum = pondCfg.build[1].num
    end
    local constructMax = addConstructNum ~= 0 and PlayerData:GetConstructionProportion(DataModel.StationId) >= DataModel.curStage.constructNum
    if constructMax then
      return 80602598
    end
    local ticketMax = pondCfg.ticket ~= 0 and DataModel.park.ticket >= DataModel.park.maxTicket
    if ticketMax then
      return 80602599
    end
    local taxMax = pondCfg.tax ~= 0 and 0 >= DataModel.park.tax
    if taxMax then
      return 80602600
    end
    local divideMax = pondCfg.divide ~= 0 and DataModel.park.divide >= DataModel.StationCA.maxDivide
    if divideMax then
      return 80602601
    end
  end
  return 0
end

function DataModel:OpenConstructStage()
  local row = {}
  for k, v in pairs(DataModel.ConstructNowCA) do
    row[k] = v
  end
  row.ConstructMaxNum = DataModel.ConstructMaxNum
  row.ConstructNowNum = DataModel.ConstructNowNum
  row.Index_Construct = DataModel.Index_Construct
  row.stationId = DataModel.StationId
  CommonTips.OpenConstructStage(row)
end

function DataModel:RefreshLeftData(first)
  DataModel.ConstructMaxNum = 0
  DataModel.ConstructNowNum = 0
  DataModel.ConstructNowCA = {}
  for k, v in pairs(DataModel.StationList.construction) do
    DataModel.ConstructNowNum = DataModel.ConstructNowNum + v.proportion
  end
  local count = 0
  for i = 1, #DataModel.StationCA.constructStageList do
    local row = DataModel.StationCA.constructStageList[i]
    DataModel.ConstructMaxNum = DataModel.ConstructMaxNum + row.constructNum
    DataModel.ConstructNowCA = row
    count = i
    if row.state and row.state ~= -1 and DataModel.ConstructNowNum >= DataModel.ConstructMaxNum and DataModel.StationState < row.state then
      DataModel.StationState = row.state
      PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state = row.state
    end
    if DataModel.ConstructNowNum <= DataModel.ConstructMaxNum then
      break
    end
  end
  DataModel.Index_Construct = count
  local Group_Zhu = View.Group_Zhu
  local row_config = DataModel.StationCA.constructStageList[count]
  local row_server = DataModel.StationList.construction[count]
  Group_Zhu.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  Group_Zhu.Txt_Name:SetText(DataModel.StationName)
  Group_Zhu.Img_Icon:SetSprite(DataModel.StationCA.buildingIconPath)
  local Group_Construct = Group_Zhu.Group_Construct
  Group_Construct.Txt_Num:SetText(row_server.proportion .. "/" .. row_config.constructNum)
  Group_Construct.Txt_Dec:SetText(DataModel.ConstructNowCA.name)
  Group_Construct.Img_PB:SetFilledImgAmount(row_server.proportion / row_config.constructNum)
  Group_Construct.Btn_Construct:SetSprite(DataModel.StationCA.constructIconPath)
  Group_Construct.Img_RedPoint:SetActive(false)
  local stageRewardList = PlayerData:GetFactoryData(DataModel.ConstructNowCA.id).stageRewardList
  local count = 0
  for k, v in pairs(stageRewardList) do
    if v.construct <= DataModel.ConstructNowNum and row_server.rec_index[k] == nil then
      count = count + 1
    end
  end
  if count ~= 0 then
    Group_Construct.Img_RedPoint:SetActive(true)
  end
end

function DataModel:OpenStorePage(isReopen)
  local storeList = self.StationCA.exchangeStoreList
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
  if isReopen then
    self:RefreshStoreInfo(storeId, remainTime)
    self:RefreshStoreLeftData()
  else
    Net:SendProto("shop.info", function(json)
      self:RefreshStoreInfo(storeId, remainTime)
    end, storeId)
    Net:SendProto("station.construction_info", function()
      self:RefreshStoreLeftData()
    end)
  end
end

function DataModel:RefreshStoreInfo(storeId, remainTime)
  self:ShowNPCTalk(self.NPCDialogEnum.enterExchangeText)
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Exchange")
  local groupStore = View.Group_Exchange
  groupStore.self:SetActive(true)
  View.self:PlayAnim("Exchange")
  local storeCA = PlayerData:GetFactoryData(storeId, "StoreFactory")
  self.exchangeStoreCA = storeCA
  local isTime = storeCA.isTime
  local storeTop = groupStore.Group_Ding
  storeTop.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  storeTop.Group_Time:SetActive(isTime)
  if isTime then
    storeTop.Group_Time.Txt_Time:SetText(string.format(GetText(80601093), math.floor(remainTime / 86400)))
  end
  local storeMid = groupStore.Group_Middle
  storeMid.Group_Title.Txt_Title:SetText(self.StationCA.exchangeName)
  if DataModel.StationCA.exchangeIconPath ~= nil and DataModel.StationCA.exchangeIconPath ~= "" then
    storeMid.Group_Title.Img_Title:SetSprite(DataModel.StationCA.exchangeIconPath)
  end
  if DataModel.StationCA.exchangePagePath ~= nil and DataModel.StationCA.exchangePagePath ~= "" then
    storeMid.Img_Di:SetSprite(DataModel.StationCA.exchangePagePath)
  end
  local serverItems = PlayerData.ServerData.shops[tostring(storeCA.id)].items
  local itemBuyCount = {}
  for k, v in pairs(serverItems) do
    itemBuyCount[tonumber(v.id)] = v.py_cnt
  end
  self.itemBuyCount = itemBuyCount
  local shopList = storeCA.shopList
  local itemList = {}
  for i = 1, #shopList do
    local itemCA = PlayerData:GetFactoryData(shopList[i].id, "CommondityFactory")
    if itemCA.isTime then
      if TimeUtil:IsActive(itemCA.startTime, itemCA.endTime) then
        itemList[#itemList + 1] = shopList[i]
      end
    else
      itemList[#itemList + 1] = shopList[i]
    end
    itemList[#itemList].idx = #itemList
    itemList[#itemList].commodityIndex = i
  end
  table.sort(itemList, function(e1, e2)
    local w1 = self:GetItemWeight(e1.id)
    local w2 = self:GetItemWeight(e2.id)
    if w1 ~= w2 then
      return w1 > w2
    else
      return e1.idx < e2.idx
    end
  end)
  self.itemList = itemList
  self.notEnoughMap = {}
  storeMid.ScrollGrid_List.grid.self:SetDataCount(#itemList)
  storeMid.ScrollGrid_List.grid.self:RefreshAllElement()
  storeMid.ScrollGrid_List.grid.self:MoveToTop()
end

function DataModel:RefreshStoreLeftData()
  DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
  DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
  DataModel:RefreshLeftData()
end

function DataModel:GetItemWeight(itemId)
  local ca = PlayerData:GetFactoryData(itemId)
  if not ca.purchase then
    return 1
  elseif 0 < ca.purchaseNum - (self.itemBuyCount[tonumber(itemId)] or 0) then
    return 1
  else
    return 0
  end
end

DataModel.SALE_STATUS = {batch = 1, single = 2}

function DataModel:OpenSalePage(initStatu)
  self:ShowNPCTalk(self.NPCDialogEnum.enterSaleText)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Sale")
  local groupSale = View.Group_Sale
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(true)
  groupSale.self:SetActive(true)
  View.self:PlayAnim("Sale")
  groupSale.Group_Ding.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  groupSale.Group_Middle.Img_Di:SetSprite(self.StationCA.exchangePagePath)
  groupSale.Group_Middle.Group_Title.Img_Title:SetSprite(self.StationCA.exchangeIconPath)
  groupSale.Group_Middle.Group_Title.Txt_Title:SetText(self.StationCA.saleName)
  groupSale.Group_Middle.Group_Up.Img_RedPoint:SetActive(PlayerData:IsHighRecycleClicked(self.StationCA.id))
  self.selectedCount = 0
  self.totalItemCount = 0
  self.selectedPrice = 0
  self:RefreshSaleList()
  self:SetSaleStatus(initStatu or self.SALE_STATUS.batch)
  self:RefreshSelectNumAndPrice()
  self:SetAllSaleItemSelected(false, true)
  Net:SendProto("station.construction_info", function()
    DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
    DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
    DataModel:RefreshLeftData()
  end)
end

function DataModel:RefreshSaleList()
  local saleList = {}
  local caList = self.StationCA.materialRecycleList
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for i = 1, #caList do
    local itemId = caList[i].id
    local haveNum = PlayerData:GetGoodsById(itemId).num
    local priceRate = self.highRecyclableMap[tostring(itemId)] == true and homeConfig.highCoefficient or 1
    if 0 < haveNum then
      local itemCA = PlayerData:GetFactoryData(itemId)
      local saleFVO = {
        id = itemId,
        quality = itemCA.qualityInt + 1,
        num = haveNum,
        isSelected = false,
        priceRate = priceRate
      }
      saleList[#saleList + 1] = saleFVO
    end
  end
  table.sort(saleList, function(e1, e2)
    if e1.quality ~= e2.quality then
      return e1.quality > e2.quality
    else
      return e1.id < e2.id
    end
  end)
  self.saleList = saleList
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:SetDataCount(#saleList)
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:MoveToTop()
  View.Group_Sale.Group_Middle.Group_Empty.self:SetActive(#saleList <= 0)
end

function DataModel:SetSaleItemSelected(index, isSelected, refreshElement)
  local itemFVO = self.saleList[index]
  if itemFVO.isSelected == isSelected then
    return
  end
  itemFVO.isSelected = isSelected
  local itemCA = PlayerData:GetFactoryData(itemFVO.id)
  if isSelected then
    self.selectedCount = self.selectedCount + 1
    self.totalItemCount = self.totalItemCount + itemFVO.num
    self.selectedPrice = self.selectedPrice + math.floor(itemCA.rewardList[1].num * itemFVO.priceRate) * itemFVO.num
  else
    self.selectedCount = math.max(0, self.selectedCount - 1)
    self.totalItemCount = math.max(0, self.totalItemCount - itemFVO.num)
    self.selectedPrice = math.max(0, self.selectedPrice - math.floor(itemCA.rewardList[1].num * itemFVO.priceRate) * itemFVO.num)
  end
  if refreshElement == true then
    View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  end
end

function DataModel:SetAllSaleItemSelected(isSelected, ignoreScrollGrid)
  for i = 1, #self.saleList do
    self:SetSaleItemSelected(i, isSelected)
  end
  if ignoreScrollGrid ~= true then
    View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Group_SelectAll.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectSSR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectSR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectN.Group_On.self:SetActive(isSelected)
end

function DataModel:SetSaleItemsSelectedByQuality(quality, isSelected)
  for i = 1, #self.saleList do
    if quality == self.saleList[i].quality then
      self:SetSaleItemSelected(i, isSelected)
    end
  end
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Group_SelectAll.Group_On.self:SetActive(DataModel.selectedCount == #DataModel.saleList)
  self:GetSelectBtnByQuality(quality):SetActive(isSelected)
end

function DataModel:RefreshSelectNumAndPrice()
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Txt_SelectNum:SetText(self.totalItemCount)
  groupBottom.Group_Earnings.Txt_Num:SetText(self.selectedPrice)
end

function DataModel:SetSaleStatus(status)
  self.saleStatus = status
  local groupMid = View.Group_Sale.Group_Middle
  local groupSwitch = groupMid.Group_Switch
  groupSwitch.Group_Single.Group_On.self:SetActive(status == self.SALE_STATUS.single)
  groupSwitch.Group_Batch.Group_On.self:SetActive(status == self.SALE_STATUS.batch)
  if status == self.SALE_STATUS.single then
    self:SetAllSaleItemSelected(false)
    self:RefreshSelectNumAndPrice()
  end
end

function DataModel:GetSelectBtnByQuality(quality)
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  if quality == 4 then
    return groupBottom.Group_SelectSSR.Group_On.self
  elseif quality == 3 then
    return groupBottom.Group_SelectSR.Group_On.self
  elseif quality == 2 then
    return groupBottom.Group_SelectR.Group_On.self
  elseif quality == 1 then
    return groupBottom.Group_SelectN.Group_On.self
  end
end

function DataModel:SetUptipsShow(isShow)
  local group = View.Group_Sale.Group_Middle.Group_UpTips
  group.self:SetActive(isShow)
  if not isShow then
    return
  end
  group.Img_Di:SetSprite(self.StationCA.saleHighPricePath)
  local recyclableList = DataModel.recyclableList
  group.Img_Up.Txt_Num:SetText(PlayerData:GetFactoryData(99900014, "ConfigFactory").highCoefficient)
  group.ScrollGrid_List.grid.self:SetDataCount(#recyclableList)
  group.ScrollGrid_List.grid.self:RefreshAllElement()
  group.ScrollGrid_List.grid.self:MoveToTop()
end

return DataModel
