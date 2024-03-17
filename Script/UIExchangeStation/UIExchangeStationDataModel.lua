local View = require("UIExchangeStation/UIExchangeStationView")
local DataModel = {
  StationId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
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
  if first then
    if DataModel.InitMode == "Exchange" then
      DataModel:OpenStorePage(true)
    else
      View.self:PlayAnim("Main")
      View.Group_Exchange:SetActive(false)
      View.Group_Main.self:SetActive(true)
      View.Group_Zhu.self:SetActive(false)
    end
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  end
  View.Group_Main.StaticGrid_List.grid.self:SetDataCount(#DataModel.BuildCA.exchangeOpenPageList)
  View.Group_Main.StaticGrid_List.grid.self:RefreshAllElement()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.StationCA = stationCA
  DataModel:SetNPC()
  if DataModel.HideBg == true then
    View.Img_BG:SetActive(false)
  else
    View.Img_BG:SetActive(true)
    View.Img_BG:SetSprite(DataModel.BgPath)
    View.Img_BG:SetColor(DataModel.BgColor)
  end
  View.Group_CommonTopLeft.Btn_Help.self:SetActive(DataModel.HelpId ~= nil)
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  View.Group_Main.Group_NpcInfo.Txt_Name:SetText(DataModel.StationName)
  View.Group_Main.Group_NpcInfo.Img_Icon:SetSprite(DataModel.BuildCA.buildingPath)
  if self.BuildCA.isShowConstruct then
    Net:SendProto("station.construction_info", function()
      DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
      DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
      DataModel:RefreshLeftData(first)
    end)
  end
  if self.BuildCA.isShowReputation then
    DataModel:RefreshGroupZhu()
    local HomeCommon = require("Common/HomeCommon")
    HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId)
  end
end

function DataModel:RefreshGroupZhu()
  local Group_Zhu = View.Group_Zhu
  Group_Zhu.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  Group_Zhu.Txt_Name:SetText(DataModel.StationName)
  Group_Zhu.Img_Icon:SetSprite(DataModel.BuildCA.buildingPath)
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
  DataModel:RefreshGroupZhu()
  local row_config = DataModel.StationCA.constructStageList[count]
  local row_server = DataModel.StationList.construction[count]
  local Group_Construct = View.Group_Zhu.Group_Construct
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
  local storeList = self.BuildCA.exchangeStoreList
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
    if self.BuildCA.isShowConstruct then
      self:RefreshStoreLeftData()
    end
  else
    Net:SendProto("shop.info", function(json)
      self:RefreshStoreInfo(storeId, remainTime)
    end, storeId)
    if self.BuildCA.isShowConstruct then
      Net:SendProto("station.construction_info", function()
        self:RefreshStoreLeftData()
      end)
    end
  end
end

function DataModel:RefreshStoreInfo(storeId, remainTime)
  self:ShowNPCTalk(self.NPCDialogEnum.enterExchangeText)
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(self.BuildCA.isShowConstruct or self.BuildCA.isShowReputation)
  View.Group_Zhu.Group_Reputation.self:SetActive(self.BuildCA.isShowReputation)
  View.Group_Zhu.Group_Construct.self:SetActive(self.BuildCA.isShowConstruct)
  local groupStore = View.Group_Exchange
  groupStore.self:SetActive(true)
  View.self:PlayAnim("Exchange")
  local storeCA = PlayerData:GetFactoryData(storeId, "StoreFactory")
  self.exchangeStoreCA = storeCA
  local storeTop = groupStore.Group_Ding
  storeTop.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  local isTime = storeCA.isTime
  storeTop.Group_Time:SetActive(isTime)
  if isTime then
    storeTop.Group_Time.Txt_Time:SetText(string.format(GetText(80601093), math.floor(remainTime / 86400)))
  end
  local storeMid = groupStore.Group_Middle
  storeMid.Group_Title.Txt_Title:SetText(self.BuildCA.exchangeName)
  if self.BuildCA.exchangePath ~= nil and self.BuildCA.exchangePath ~= "" then
    storeMid.Group_Title.Img_Title:SetSprite(self.BuildCA.exchangePath)
  end
  if self.BuildCA.pagePath ~= nil and self.BuildCA.pagePath ~= "" then
    storeMid.Img_Di:SetSprite(self.BuildCA.pagePath)
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
  if not self.BuildCA.isShowConstruct then
    return
  end
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

function DataModel:RefreshWeaponStore()
  local storeId = self:GetOpenWeaponStoreId()
  if storeId == nil then
    return
  end
  Net:SendProto("shop.info", function(json)
    DataModel.isWeaponReady = true
  end, storeId)
end

function DataModel:OpenWeaponStore(uiPath)
  if DataModel.isWeaponReady ~= true then
    return
  end
  local storeId = self:GetOpenWeaponStoreId()
  if storeId == nil then
    return
  end
  UIManager:Open(uiPath, Json.encode({storeId = storeId, inited = true}))
end

function DataModel:GetOpenWeaponStoreId()
  local storeList = self.BuildCA.exchangeWeaponList
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
  return storeId
end

return DataModel
