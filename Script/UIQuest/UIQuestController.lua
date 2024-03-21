local View = require("UIQuest/UIQuestView")
local CommonItem = require("Common/BtnItem")
local DataModel = require("UIQuest/UIQuestDataModel")
local Controller = {}

function Controller:RequestAllQuest()
  View.Group_Info.self:SetActive(false)
  View.ScrollView_QuestList.self:SetActive(false)
  Net:SendProto("quest.list", function(json)
    PlayerData.ServerData.quests = json.quests
    QuestProcess.UpdateCacheQuest(true)
    DataModel.InitAllQuests(json.quests)
    View.ScrollView_QuestList.Viewport.Content.ScrollGrid_COCQuest.self:SetHeight(DataModel.ConstChildElementHeight)
    View.ScrollView_QuestList.Viewport.Content.ScrollGrid_MainQuest.self:SetHeight(DataModel.ConstChildElementHeight)
    View.ScrollView_QuestList.Viewport.Content.ScrollGrid_SideQuest.self:SetHeight(DataModel.ConstChildElementHeight)
    View.ScrollView_QuestList.self:SetActive(true)
    Controller:FirstShow()
  end, EnumDefine.QuestListDefine.All)
end

local autoSelectQuest = function(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA == nil then
    return false
  end
  local type = DataModel.QuestType[questCA.questType]
  for k, v in pairs(DataModel.AllQuests[type]) do
    local id = v.id
    if questId == id then
      local mergeIdx = DataModel.GetMergeIdx(type, k)
      if type == DataModel.QuestType.Order then
        Controller:ShowOrderDetailInfo(mergeIdx)
      else
        Controller:ShowDetailInfo(mergeIdx)
      end
      Controller:SelectMainTitle(type, nil, true)
      return true
    end
  end
  return false
end

function Controller:FirstShow()
  local element = View.ScrollView_QuestList.Viewport.Content
  element.ScrollGrid_MainQuest.self:SetActive(false)
  element.ScrollGrid_SideQuest.self:SetActive(false)
  element.ScrollGrid_COCQuest.self:SetActive(false)
  element.ScrollGrid_OrderQuest.self:SetActive(false)
  element.Btn_MainQuest.Group_UnSelected:SetActive(true)
  element.Btn_MainQuest.Group_Selected:SetActive(false)
  element.Btn_SideQuest.Group_UnSelected:SetActive(true)
  element.Btn_SideQuest.Group_Selected:SetActive(false)
  element.Btn_COCQuest.Group_UnSelected:SetActive(true)
  element.Btn_COCQuest.Group_Selected:SetActive(false)
  element.Btn_OrderQuest.Group_UnSelected:SetActive(true)
  element.Btn_OrderQuest.Group_Selected:SetActive(false)
  Controller:RefreshMainTitleNewState(DataModel.QuestType.Main)
  Controller:RefreshMainTitleNewState(DataModel.QuestType.Side)
  Controller:RefreshMainTitleNewState(DataModel.QuestType.Home)
  Controller:RefreshMainTitleNewState(DataModel.QuestType.Order)
  View.Group_Info.self:SetActive(false)
  if DataModel.Data and DataModel.Data.questId and autoSelectQuest(DataModel.Data.questId) then
    return
  end
  if DataModel.QuestTrace ~= nil and autoSelectQuest(DataModel.QuestTrace.id) then
    return
  end
  local type = DataModel.QuestType.Main
  if #DataModel.AllQuests[type] > 0 then
    local mergeIdx = DataModel.GetMergeIdx(type, 1)
    Controller:ShowDetailInfo(mergeIdx)
    Controller:SelectMainTitle(type)
    return
  end
  type = DataModel.QuestType.Side
  if #DataModel.AllQuests[type] > 0 then
    local mergeIdx = DataModel.GetMergeIdx(type, 1)
    Controller:ShowDetailInfo(mergeIdx)
    Controller:SelectMainTitle(type)
    return
  end
  type = DataModel.QuestType.Home
  if #DataModel.AllQuests[type] > 0 then
    local mergeIdx = DataModel.GetMergeIdx(type, 1)
    Controller:ShowDetailInfo(mergeIdx)
    Controller:SelectMainTitle(type)
    return
  end
  type = DataModel.QuestType.Order
  if #DataModel.AllQuests[type] > 0 then
    local mergeIdx = DataModel.GetMergeIdx(type, 1)
    Controller:ShowOrderDetailInfo(mergeIdx)
    Controller:SelectMainTitle(type)
    return
  end
  View.Group_Info.self:SetActive(false)
  View.Group_Null.self:SetActive(true)
end

function Controller:RefreshMainTitleNewState(type)
  local element = View.ScrollView_QuestList.Viewport.Content
  if type == DataModel.QuestType.Main then
    element.Btn_MainQuest.Img_New:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.QuestMain) > 0)
  elseif type == DataModel.QuestType.Side then
    element.Btn_SideQuest.Img_New:SetActive(0 < RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.QuestSide))
  elseif type == DataModel.QuestType.Home then
    element.Btn_COCQuest.Img_New:SetActive(0 < RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.QuestHome))
  elseif type == DataModel.QuestType.Order then
    element.Btn_OrderQuest.Img_New:SetActive(0 < RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.QuestOrder))
  end
end

function Controller:SelectMainTitle(type, force, noAutoSelect)
  DataModel.CurSelectedMainTitle = type
  local childScroll = Controller:GetTypeScroll(type)
  local btn = Controller:GetTypeBtn(type)
  if DataModel.LastShowScroll ~= nil and DataModel.LastShowScroll ~= childScroll then
    DataModel.LastShowScroll.self:SetActive(false)
    DataModel.LastShowScroll = nil
  end
  if DataModel.LastSelectBtn ~= nil and DataModel.LastSelectBtn ~= btn then
    DataModel.LastSelectBtn.Group_UnSelected.self:SetActive(true)
    DataModel.LastSelectBtn.Group_Selected.self:SetActive(false)
  end
  local isActive = childScroll.self.IsActive and not force
  childScroll.self:SetActive(not isActive)
  btn.Group_UnSelected.self:SetActive(isActive)
  btn.Group_Selected.self:SetActive(not isActive)
  if not isActive then
    local count = #DataModel.AllQuests[type]
    local height = 1 <= count and 93 * (count - 1) + 93 or 46
    childScroll.grid.self:SetDataCount(count)
    childScroll.grid.self:MoveToTop()
    childScroll.grid.self:RefreshAllElement()
    if height > DataModel.ConstChildElementHeight then
      childScroll.self:SetHeight(DataModel.ConstChildElementHeight)
      childScroll.grid.self.ScrollRect.enabled = true
    else
      childScroll.self:SetHeight(height)
      childScroll.grid.self.ScrollRect.enabled = false
    end
    DataModel.LastShowScroll = childScroll
    DataModel.LastSelectBtn = btn
    if not noAutoSelect and 0 < count then
      local mergeIdx = DataModel.GetMergeIdx(type, 1)
      if type == DataModel.QuestType.Order then
        Controller:ShowOrderDetailInfo(mergeIdx)
      else
        Controller:ShowDetailInfo(mergeIdx)
      end
    end
  end
end

function Controller:GetTypeScroll(type)
  local childScroll
  if type == DataModel.QuestType.Main then
    childScroll = View.ScrollView_QuestList.Viewport.Content.ScrollGrid_MainQuest
  elseif type == DataModel.QuestType.Home then
    childScroll = View.ScrollView_QuestList.Viewport.Content.ScrollGrid_COCQuest
  elseif type == DataModel.QuestType.Side then
    childScroll = View.ScrollView_QuestList.Viewport.Content.ScrollGrid_SideQuest
  elseif type == DataModel.QuestType.Order then
    childScroll = View.ScrollView_QuestList.Viewport.Content.ScrollGrid_OrderQuest
  end
  return childScroll
end

function Controller:GetTypeBtn(type)
  local btn
  if type == DataModel.QuestType.Main then
    btn = View.ScrollView_QuestList.Viewport.Content.Btn_MainQuest
  elseif type == DataModel.QuestType.Home then
    btn = View.ScrollView_QuestList.Viewport.Content.Btn_COCQuest
  elseif type == DataModel.QuestType.Side then
    btn = View.ScrollView_QuestList.Viewport.Content.Btn_SideQuest
  elseif type == DataModel.QuestType.Order then
    btn = View.ScrollView_QuestList.Viewport.Content.Btn_OrderQuest
  end
  return btn
end

function Controller:SetChildElement(element, mergeIdx)
  local type, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
  local info = DataModel.AllQuests[type][childIdx]
  local isQuestTrace = DataModel.QuestTrace ~= nil and DataModel.QuestTrace.id == info.id
  element.Btn_Quest.Img_Target:SetActive(isQuestTrace)
  element.Btn_Quest.Group_Selected.Img_Target:SetActive(isQuestTrace)
  element.Btn_Quest.Group_Selected:SetActive(mergeIdx == DataModel.CurSelected)
  element.Btn_Quest.Txt_Name:SetActive(mergeIdx ~= DataModel.CurSelected)
  element.Btn_Quest.self:SetClickParam(mergeIdx)
  element.Btn_Quest.Txt_Name:SetText(info.questShowName)
  element.Btn_Quest.Group_Selected.Txt_Name:SetText(info.questShowName)
  element.Img_New:SetActive(info.isNew)
  element.Btn_Quest.Txt_Position:SetActive(info.stationShowName and info.stationShowName ~= "")
  element.Btn_Quest.Txt_Position:SetText(info.stationShowName)
  element.Btn_Quest.Group_Selected.Txt_Position:SetActive(info.stationShowName and info.stationShowName ~= "")
  element.Btn_Quest.Group_Selected.Txt_Position:SetText(info.stationShowName)
end

function Controller:SetOrderChildElement(element, mergeIdx)
  local type, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
  local info = DataModel.AllQuests[type][childIdx]
  local isQuestTrace = DataModel.QuestTrace ~= nil and DataModel.QuestTrace.id == info.id
  element.Btn_Quest.Img_Target:SetActive(isQuestTrace)
  element.Btn_Quest.Group_Selected.Img_Target:SetActive(isQuestTrace)
  element.Btn_Quest.Group_Selected.self:SetActive(mergeIdx == DataModel.CurSelected)
  element.Btn_Quest.Txt_Name:SetActive(mergeIdx ~= DataModel.CurSelected)
  element.Btn_Quest.self:SetClickParam(mergeIdx)
  element.Btn_Quest.Txt_Name:SetText("")
  element.Btn_Quest.Group_Selected.Txt_Name:SetText("")
  element.Btn_Quest.Txt_OrderName:SetText(string.format(GetText(80601326), info.orderCA.name, info.stationCA.name))
  element.Btn_Quest.Group_Selected.Txt_OrderName:SetText(string.format(GetText(80601326), info.orderCA.name, info.stationCA.name))
  element.Btn_Quest.Group_Submit:SetActive(false)
  element.Btn_Quest.Group_Selected.Group_Submit:SetActive(false)
  element.Img_New:SetActive(info.isNew)
  local count_list = 0
  local count_e = 0
  for i = 1, 3 do
    if info.orderCA.requireItemList[i] then
      count_list = count_list + 1
      if info.orderCA.requireItemList[i].num <= PlayerData:GetGoodsById(info.orderCA.requireItemList[i].id).num then
        count_e = count_e + 1
      end
    end
  end
  info.isFinish = false
  if count_list == count_e then
    info.isFinish = true
    element.Btn_Quest.Group_Submit:SetActive(true)
    element.Btn_Quest.Group_Selected.Group_Submit:SetActive(true)
  end
end

function Controller:ShowDetailInfo(mergeIdx)
  View.Group_Info.self:SetActive(true)
  View.Group_Null.self:SetActive(false)
  DataModel.CurSelected = mergeIdx
  local questType, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
  local info = DataModel.AllQuests[questType][childIdx]
  View.Group_Info.self:SetActive(true)
  View.Group_Null.self:SetActive(false)
  local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
  View.Group_Info.Txt_Name:SetText(questCA.name)
  View.Group_Info.Group_Btn.Btn_Cancel.self:SetActive(questType == DataModel.QuestType.Home)
  View.Group_Info.Group_Btn.Btn_Cancel.self:SetClickParam(tostring(mergeIdx))
  local stationName = ""
  if info.endStation ~= nil and info.endStation > 0 then
    View.Group_Info.Txt_Position:SetActive(true)
    local stationCA = PlayerData:GetFactoryData(info.endStation, "HomeStationFactory")
    stationName = stationCA.name
    View.Group_Info.Txt_Position:SetText(stationName)
  else
    View.Group_Info.Txt_Position:SetActive(false)
  end
  if questCA.cocQuestType == "Buy" or questCA.cocQuestType == "Send" then
    View.Group_Info.Txt_Target:SetText(string.format(questCA.describe, stationName))
    View.Group_Info.ScrollView_Des.Viewport.Txt_Des:SetText(string.format(questCA.story, stationName))
  else
    View.Group_Info.Txt_Target:SetText(questCA.describe)
    View.Group_Info.ScrollView_Des.Viewport.Txt_Des:SetText(questCA.story)
  end
  View.Group_Info.Txt_TargetNum:SetActive(questCA.isShowProgress)
  local serverKey = ""
  if questCA.isShowProgress then
    if questCA.cocQuestType == "Buy" then
      local serverData
      local stationInfo = PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)]
      if stationInfo ~= nil and stationInfo.quests.Buy ~= nil and stationInfo.quests.Buy[tostring(questCA.id)] ~= nil then
        serverData = stationInfo.quests.Buy[tostring(questCA.id)].info
      end
      local curNum = 0
      if serverData ~= nil and type(serverData) == "table" then
        curNum = serverData[tostring(questCA.goodsList[1].id)] or 0
      end
      local maxNum = questCA.goodsList[1].num
      View.Group_Info.Txt_TargetNum:SetText(string.format(GetText(80600776), curNum, maxNum))
    elseif questCA.questType == "Main" then
      serverKey = "mq_quests"
    elseif questCA.questType == "Side" then
      serverKey = "branch_quests"
    else
      View.Group_Info.Txt_TargetNum:SetActive(false)
    end
    if serverKey ~= "" then
      local curNum = 0
      local serverData = PlayerData.ServerData.quests[serverKey]
      if serverData and serverData[tostring(questCA.id)] then
        curNum = serverData[tostring(questCA.id)].pcnt or 0
      end
      View.Group_Info.Txt_TargetNum:SetText(string.format(GetText(80600776), curNum, questCA.num))
    end
  end
  local rewardList = questCA.rewardsList
  DataModel.CurDetailReward = rewardList
  local rewardCount = #rewardList
  if questCA.reputationList ~= nil and 0 < #questCA.reputationList then
    rewardCount = rewardCount + 1
    DataModel.CurRepReward = questCA.reputationList
  end
  if rewardCount <= 7 then
    View.Group_Info.ScrollGrid_Reward.self:SetEnable(false)
    View.Group_Info.ScrollGrid_Reward.grid.self:SetStartCorner("Center")
  else
    View.Group_Info.ScrollGrid_Reward.self:SetEnable(true)
    View.Group_Info.ScrollGrid_Reward.grid.self:SetStartCorner("Left")
  end
  View.Group_Info.ScrollGrid_Reward.grid.self:SetDataCount(rewardCount)
  View.Group_Info.ScrollGrid_Reward.grid.self:RefreshAllElement()
  View.Group_Info.Group_Btn.Btn_Navigate.self:SetClickParam(mergeIdx)
  View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetClickParam(mergeIdx)
  if QuestTrace.DeleteRedNodeData(info.id) then
    PlayerData:SetPlayerPrefs("int", "QuestRed" .. info.id, 1)
    Controller:RefreshMainTitleNewState(questType)
  end
  info.isNew = false
  local scroll = Controller:GetTypeScroll(questType)
  if scroll ~= nil and scroll.self.IsActive then
    scroll.grid.self:RefreshAllElement()
  end
  if questType ~= DataModel.LastShowType then
    scroll = Controller:GetTypeScroll(DataModel.LastShowType)
    if scroll ~= nil and scroll.self.IsActive then
      local row = DataModel.AllQuests[DataModel.LastShowType]
      if row and 0 < table.count(row) then
        scroll.grid.self:RefreshAllElement()
      end
    end
  end
  local isQuestTrace = DataModel.QuestTrace ~= nil and DataModel.QuestTrace.id == info.id
  View.Group_Info.Group_Btn.Btn_Navigate.self:SetActive(not isQuestTrace)
  View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetActive(isQuestTrace)
  View.Group_Info.Group_Order.self:SetActive(false)
  DataModel.LastShowType = questType
end

function Controller:ShowOrderDetailInfo(mergeIdx)
  View.Group_Info.self:SetActive(true)
  View.Group_Null.self:SetActive(false)
  DataModel.CurSelected = mergeIdx
  local questType, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
  local info = DataModel.AllQuests[questType][childIdx]
  View.Group_Info.self:SetActive(true)
  View.Group_Null.self:SetActive(false)
  local orderCA = info.orderCA
  View.Group_Info.Txt_Name:SetText(info.orderCA.name)
  View.Group_Info.Group_Btn.Btn_Cancel.self:SetActive(questType == DataModel.QuestType.Home)
  View.Group_Info.Group_Btn.Btn_Cancel.self:SetClickParam(tostring(mergeIdx))
  local stationName = ""
  if info.Stationid ~= nil then
    View.Group_Info.Txt_Position:SetActive(true)
    stationName = info.stationCA.name
    View.Group_Info.Txt_Position:SetText(stationName)
  else
    View.Group_Info.Txt_Position:SetActive(false)
  end
  if orderCA.cocQuestType == "Buy" or orderCA.cocQuestType == "Send" then
    View.Group_Info.Txt_Target:SetText(string.format(orderCA.describe, stationName))
  else
    View.Group_Info.Txt_Target:SetText(orderCA.describe)
  end
  View.Group_Info.ScrollView_Des.Viewport.Txt_Des:SetText("")
  View.Group_Info.Txt_TargetNum:SetActive(orderCA.isShowProgress)
  local serverKey = ""
  if orderCA.isShowProgress then
    if orderCA.cocQuestType == "Buy" then
      local serverData
      local stationInfo = PlayerData:GetHomeInfo().stations[tostring(orderCA.startStation)]
      if stationInfo ~= nil and stationInfo.quests.Buy ~= nil and stationInfo.quests.Buy[tostring(orderCA.id)] ~= nil then
        serverData = stationInfo.quests.Buy[tostring(orderCA.id)].info
      end
      local curNum = 0
      if serverData ~= nil and type(serverData) == "table" then
        curNum = serverData[tostring(orderCA.goodsList[1].id)] or 0
      end
      local maxNum = orderCA.goodsList[1].num
      View.Group_Info.Txt_TargetNum:SetText(string.format(GetText(80600776), curNum, maxNum))
    elseif orderCA.questType == "Main" then
      serverKey = "mq_quests"
    elseif orderCA.questType == "Side" then
      serverKey = "branch_quests"
    else
      View.Group_Info.Txt_TargetNum:SetActive(false)
    end
  end
  local rewardList = orderCA.rewardsList
  DataModel.CurDetailReward = rewardList
  local rewardCount = #rewardList
  if orderCA.reputationList ~= nil and 0 < #orderCA.reputationList then
    rewardCount = rewardCount + 1
    DataModel.CurRepReward = orderCA.reputationList
  end
  if rewardCount <= 7 then
    View.Group_Info.ScrollGrid_Reward.self:SetEnable(false)
    View.Group_Info.ScrollGrid_Reward.grid.self:SetStartCorner("Center")
  else
    View.Group_Info.ScrollGrid_Reward.self:SetEnable(true)
    View.Group_Info.ScrollGrid_Reward.grid.self:SetStartCorner("Left")
  end
  View.Group_Info.ScrollGrid_Reward.grid.self:SetDataCount(rewardCount)
  View.Group_Info.ScrollGrid_Reward.grid.self:RefreshAllElement()
  View.Group_Info.Group_Btn.Btn_Navigate.self:SetClickParam(mergeIdx)
  View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetClickParam(mergeIdx)
  local isQuestTrace = DataModel.QuestTrace ~= nil and DataModel.QuestTrace.id == info.id
  View.Group_Info.Group_Btn.Btn_Navigate.self:SetActive(not isQuestTrace)
  View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetActive(isQuestTrace)
  local count_list = 0
  local count_e = 0
  for i = 1, 3 do
    local obj_name = "Group_Consume" .. i
    local obj = View.Group_Info.Group_Order.Group_Item[obj_name]
    obj:SetActive(false)
    if orderCA.requireItemList[i] then
      count_list = count_list + 1
      CommonItem:SetItem(obj.Group_Item, {
        id = orderCA.requireItemList[i].id,
        num = ""
      })
      obj.Group_Item.Btn_Item:SetClickParam(orderCA.requireItemList[i].id)
      obj.Group_Cost.Txt_Need:SetText(PlayerData:TransitionNum(orderCA.requireItemList[i].num))
      obj.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(PlayerData:GetGoodsById(orderCA.requireItemList[i].id).num))
      obj.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      if orderCA.requireItemList[i].num <= PlayerData:GetGoodsById(orderCA.requireItemList[i].id).num then
        obj.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
        count_e = count_e + 1
      end
      obj:SetActive(true)
    end
  end
  View.Group_Info.Group_Order.self:SetActive(true)
  View.Group_Info.Group_Order.Group_Submit.self:SetActive(false)
  if count_list == count_e then
    View.Group_Info.Group_Order.Group_Submit.self:SetActive(true)
    info.isFinish = true
  end
  if QuestTrace.DeleteRedNodeData(info.id) then
    PlayerData:SetPlayerPrefs("int", "QuestRed" .. info.id, 1)
    Controller:RefreshMainTitleNewState(questType)
  end
  info.isNew = false
  local scroll = Controller:GetTypeScroll(questType)
  if scroll ~= nil and scroll.self.IsActive then
    scroll.grid.self:RefreshAllElement()
  end
  if questType ~= DataModel.LastShowType then
    scroll = Controller:GetTypeScroll(DataModel.LastShowType)
    if scroll ~= nil and scroll.self.IsActive then
      scroll.grid.self:RefreshAllElement()
    end
  end
  DataModel.LastShowType = questType
end

return Controller
