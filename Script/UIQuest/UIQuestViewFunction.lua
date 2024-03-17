local View = require("UIQuest/UIQuestView")
local DataModel = require("UIQuest/UIQuestDataModel")
local Controller = require("UIQuest/UIQuestController")
local CommonBtn = require("Common/BtnItem")
local ViewFunction = {
  Quest_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Quest_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Quest_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Quest_Group_Info_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.CurDetailReward[elementIndex]
    if info == nil then
      info = DataModel.CurRepReward[1]
    end
    CommonBtn:SetItem(element.Group_Item, {
      id = info.id,
      num = info.num
    })
    element.Group_Item.Btn_Item:SetClickParam(info.id)
  end,
  Quest_Group_Info_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_Btn_MainQuest_Click = function(btn, str)
    Controller:SelectMainTitle(DataModel.QuestType.Main)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_MainQuest_SetGrid = function(element, elementIndex)
    local mergeIdx = DataModel.GetMergeIdx(DataModel.QuestType.Main, elementIndex)
    Controller:SetChildElement(element, mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_MainQuest_Group_Item_Btn_Quest_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    Controller:ShowDetailInfo(mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_Btn_SideQuest_Click = function(btn, str)
    Controller:SelectMainTitle(DataModel.QuestType.Side)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_SideQuest_SetGrid = function(element, elementIndex)
    local mergeIdx = DataModel.GetMergeIdx(DataModel.QuestType.Side, elementIndex)
    Controller:SetChildElement(element, mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_SideQuest_Group_Item_Btn_Quest_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    Controller:ShowDetailInfo(mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_Btn_COCQuest_Click = function(btn, str)
    Controller:SelectMainTitle(DataModel.QuestType.Home)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_COCQuest_SetGrid = function(element, elementIndex)
    local mergeIdx = DataModel.GetMergeIdx(DataModel.QuestType.Home, elementIndex)
    Controller:SetChildElement(element, mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_COCQuest_Group_Item_Btn_Quest_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    Controller:ShowDetailInfo(mergeIdx)
  end,
  Quest_Group_Info_Group_Btn_Btn_Cancel_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    local questType, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
    local info = DataModel.AllQuests[questType][childIdx]
    local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
    if not questCA.giveUp then
      CommonTips.OpenTips(80601261)
      return
    end
    CommonTips.OnPrompt(80601037, nil, nil, function()
      Net:SendProto("station.reset_quest", function(json)
        PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests[questCA.cocQuestType][tostring(info.id)].time = -1
        PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests[questCA.cocQuestType][tostring(info.id)].info = -2
        if questCA.cocQuestType == "Send" then
          for k, v in pairs(questCA.goodsList) do
            if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] ~= nil then
              local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
              num = num - v.num
              if num <= 0 then
                PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = 0
              else
                PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num
              end
            end
          end
        end
        QuestTrace.CancelQuest(info.id)
        DataModel.CurSelected = 0
        table.remove(DataModel.AllQuests[questType], childIdx)
        View.Group_Info.self:SetActive(false)
        View.Group_Null.self:SetActive(true)
        if DataModel.CurSelectedMainTitle == questType then
          Controller:SelectMainTitle(DataModel.CurSelectedMainTitle, true)
        end
        local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
        if questCA.cocQuestType == "Passenger" then
          local psgData = require("UIPassenger/UIPassengerDataModel")
          psgData.RefreshPassenger(json.passenger, json.furniture)
        end
      end, info.id)
    end)
  end,
  Quest_Group_Info_Group_Btn_Btn_Navigate_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    local type, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
    local info = DataModel.AllQuests[type][childIdx]
    local curTime = TimeUtil:GetServerTimeStamp()
    if info.endTime ~= -1 and curTime >= info.endTime then
      table.remove(DataModel.AllQuests[type], childIdx)
      local scroll = Controller:GetTypeScroll(type)
      if scroll.self.IsActive then
        scroll.grid.self:SetDataCount(#DataModel.AllQuests[type])
        scroll.grid.self:RefreshAllElement()
      end
      View.Group_Info.self:SetActive(false)
      View.Group_Null.self:SetActive(true)
      return
    end
    local t = {}
    table.insert(t, info)
    PlayerData:SetQuestTrace(t)
    local oldType
    if DataModel.QuestTrace ~= nil then
      local id = DataModel.QuestTrace.id
      local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
      oldType = DataModel.QuestType[questCA.questType]
    end
    DataModel.QuestTrace = info
    local scroll = Controller:GetTypeScroll(type)
    if scroll.self.IsActive then
      scroll.grid.self:RefreshAllElement()
    end
    if oldType ~= nil and oldType ~= type then
      scroll = Controller:GetTypeScroll(oldType)
      if scroll.self.IsActive then
        scroll.grid.self:RefreshAllElement()
      end
    end
    View.Group_Info.Group_Btn.Btn_Navigate.self:SetActive(false)
    View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetActive(true)
  end,
  Quest_Group_Info_Group_Btn_Btn_CancelNavigate_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    local type, childIdx = DataModel.GetDetailTypeAndIdx(mergeIdx)
    local info = DataModel.AllQuests[type][childIdx]
    PlayerData:RemoveQuestTrace()
    DataModel.QuestTrace = nil
    local curTime = TimeUtil:GetServerTimeStamp()
    if info.endTime ~= -1 and curTime >= info.endTime then
      table.remove(DataModel.AllQuests[type], childIdx)
      local scroll = Controller:GetTypeScroll(type)
      if scroll.self.IsActive then
        scroll.grid.self:SetDataCount(#DataModel.AllQuests[type])
        scroll.grid.self:RefreshAllElement()
      end
      View.Group_Info.self:SetActive(false)
      View.Group_Null.self:SetActive(true)
      return
    end
    local scroll = Controller:GetTypeScroll(type)
    if scroll.self.IsActive then
      scroll.grid.self:RefreshAllElement()
    end
    View.Group_Info.Group_Btn.Btn_Navigate.self:SetActive(true)
    View.Group_Info.Group_Btn.Btn_CancelNavigate.self:SetActive(false)
  end,
  Quest_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Quest_Group_Info_Group_Order_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Quest_Group_Info_Group_Order_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Quest_Group_Info_Group_Order_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_Btn_OrderQuest_Click = function(btn, str)
    Controller:SelectMainTitle(DataModel.QuestType.Order)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_OrderQuest_SetGrid = function(element, elementIndex)
    local mergeIdx = DataModel.GetMergeIdx(DataModel.QuestType.Order, elementIndex)
    Controller:SetOrderChildElement(element, mergeIdx)
  end,
  Quest_ScrollView_QuestList_Viewport_Content_ScrollGrid_OrderQuest_Group_Item_Btn_Quest_Click = function(btn, str)
    local mergeIdx = tonumber(str)
    Controller:ShowOrderDetailInfo(mergeIdx)
  end,
  Quest_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  Quest_Group_Info_Btn_Receive_Click = function(btn, str)
    local id = tonumber(str)
    local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
    Net:SendProto("quest.recv_rewards", function(json)
      UIManager:GoBack()
      local serverKey = ""
      if questCA.questType == "Main" then
        serverKey = "mq_quests"
      elseif questCA.questType == "Side" then
        serverKey = "branch_quests"
      end
      PlayerData.ServerData.quests[serverKey][tostring(id)] = nil
      if json.current_quests ~= nil then
        for k, v in pairs(json.current_quests) do
          questCA = PlayerData:GetFactoryData(k, "QuestFactory")
          if questCA.questType == "Main" then
            serverKey = "mq_quests"
          elseif questCA.questType == "Side" then
            serverKey = "branch_quests"
          end
          if serverKey ~= "" then
            PlayerData.ServerData.quests[serverKey][k] = v
          end
        end
      end
      QuestTrace.CompleteQuestOne(id)
      CommonTips.OpenQuestsCompleteTip({
        [1] = id
      })
    end, id)
  end
}
return ViewFunction
