local CommonItem = require("Common/BtnItem")
local View = require("UIActivityMain/UIActivityMainView")
local DataModel = require("UIActivityMain/UIActivityMainDataModel")
local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ServerProgressDataModel = require("UIServerProgress/UIServerProgressDataModel")
local PersonalProgressDataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local AchievementDataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local Controller = {}

function Controller:InitPageShow()
  for k, v in pairs(DataModel.ClosePageList) do
    View[v].self:SetActive(false)
  end
end

function Controller:Init(index)
  print_r(PlayerData.ServerData.all_activities, "活动数据")
  local ActivityCA = PlayerData:GetFactoryData(99900059).activeList
  DataModel.ClosePageList = {}
  DataModel.LeftList = {}
  for k, v in pairs(ActivityCA) do
    local activeCA = PlayerData:GetFactoryData(v.id, "ActivityFactory")
    if TimeUtil:IsActive(v.startTime, v.endTime) then
      local tagCA = PlayerData:GetFactoryData(v.tag)
      local row = v
      row.tagCA = tagCA
      row.activeCA = activeCA
      table.insert(DataModel.LeftList, row)
    end
    table.insert(DataModel.ClosePageList, activeCA.showUI)
  end
  View.Group_List.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.LeftList))
  View.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
  Controller:InitPageShow()
  DataModel.ChooseLeftIndex = nil
  Controller:ClickLeftActive(index or 1)
end

function Controller:SetElement(element, elementIndex)
  local row = DataModel.LeftList[tonumber(elementIndex)]
  local Btn_Tab = element.Btn_Tab
  Btn_Tab:SetClickParam(elementIndex)
  Btn_Tab.Img_Unselected:SetActive(true)
  Btn_Tab.Img_Selected:SetActive(false)
  Btn_Tab.Img_Red:SetActive(DataModel.GetLeftListRedState(row.tagCA.tagName))
  Btn_Tab.Img_New:SetActive(false)
  Btn_Tab.Txt_Name:SetText(GetText(row.name))
  Btn_Tab:SetSprite(row.png)
end

function Controller:Open_Group_SignIn(row)
  for k, v in pairs(PlayerData:GetSignInfo()) do
    DataModel.SignInConfig = PlayerData:GetFactoryData(k)
    DataModel.SignInConfig.Sever = v
  end
  View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:SetDataCount(table.count(DataModel.SignInConfig.SigninAwardList))
  View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:RefreshAllElement()
  if DataModel.SignInConfig.Sever.count >= table.count(DataModel.SignInConfig.SigninAwardList) - 2 then
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(table.count(DataModel.SignInConfig.SigninAwardList) - 2)
  else
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(DataModel.SignInConfig.Sever.count + 1)
  end
  View.Group_SignIn.Img_BG:SetSprite(row.activeCA.bgPath)
  View.Group_SignIn.Img_Background:SetActive(false)
  View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.self:SetActive(false)
  if row.activeCA.isTime == true then
    View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.self:SetActive(true)
    local timeStart = TimeUtil:GetTimeTable(DataModel.SignInConfig.startTime)
    local timeEnd = TimeUtil:GetTimeTable(DataModel.SignInConfig.endTime)
    local a_1 = timeStart.year .. "/" .. timeStart.month .. "/" .. timeStart.day
    local b_1 = timeStart.hour .. ":" .. timeStart.minute
    local a_2 = timeEnd.year .. "/" .. timeEnd.month .. "/" .. timeEnd.day
    local b_2 = timeEnd.hour .. ":" .. timeEnd.minute
    local str = string.format(GetText(80602405), a_1, b_1, a_2, b_2)
    View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.Txt_EndTime:SetText(str)
  end
end

function Controller:SignInSetElement(element, elementIndex)
  local row = DataModel.SignInConfig.SigninAwardList[tonumber(elementIndex)]
  local Group_Item = element.Group_Item
  Group_Item.Img_Icon:SetSprite(row.sealPic)
  Group_Item.Img_Mark:SetActive(false)
  Group_Item.BtnPolygon_BG:SetClickParam(elementIndex)
  Group_Item.Img_Oh:SetActive(false)
  local sign = PlayerData:GetSignInfo()[tostring(DataModel.SignInConfig.id)]
  if tonumber(elementIndex) <= sign.count then
    Group_Item.Img_Mark:SetActive(true)
  else
    Group_Item.Img_Mark:SetActive(false)
  end
  if tonumber(elementIndex) == sign.count + 1 and sign.status == 0 then
    Group_Item.Img_Oh:SetActive(true)
  end
end

function Controller:SignInClickElement(str)
  local index = str
  local sign = PlayerData:GetSignInfo()[tostring(DataModel.SignInConfig.id)]
  local element = View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:GetElementByIndex(index - 1)
  local id = DataModel.SignInConfig.id
  if sign then
    if sign.status == 1 then
      if index <= sign.count then
        CommonTips.OpenTips(80600191)
        return
      else
        CommonTips.OpenTips(80600194)
        return
      end
    elseif index == sign.count + 1 then
      if sign.status == 1 then
        CommonTips.OpenTips(80600191)
        return
      end
      Net:SendProto("main.sign_in", function(json)
        SdkReporter.TrackSignReward({
          id = id,
          day = sign.count + 1
        })
        if json.reward.role then
          for k, v in pairs(json.reward.role) do
            local ca = PlayerData:GetFactoryData(k)
            local hero_list = {}
            hero_list.hero_id = ca.id
            hero_list.hero_name = ca.name
            hero_list.event_seq = "main.sign_in"
            hero_list.get_times = PlayerData:GetSeverTime()
            ReportTrackEvent.hero_get(hero_list)
          end
        end
        element.Group_Item.Img_Mark:SetActive(true)
        element.Group_Item.Img_Oh:SetActive(false)
        CommonTips.OpenShowItem(json.reward)
        PlayerData.ServerData.sign_info = json.user_info.sign_info
        Controller:RefreshLeftRedState()
      end, DataModel.SignInConfig.id)
    elseif index < sign.count + 1 then
      CommonTips.OpenTips(80600191)
      return
    else
      CommonTips.OpenTips(80600194)
      return
    end
  end
end

function Controller:QuestIsFinish(questId)
  if questId == nil then
    return false
  end
  local type = PlayerData.GetQuestState(questId)
  if type == EnumDefine.EQuestState.UnFinish or type == EnumDefine.EQuestState.Lock then
    return false
  end
  return true
end

function Controller:SkipStation(stationId)
  UIManager:Open("UI/MainUI/MainUI", nil, function()
    local parms = {}
    parms.index = DataModel.ChooseLeftIndex
    UIManager:Open("UI/Activity/ActivityMain", Json.encode(parms))
  end)
  local MapController = require("UIHome/UIHomeMapController")
  MapController:AutoToClickStation(stationId, true)
end

function Controller:SkipQuest(questId)
  if questId == nil then
    return
  end
  UIManager:Open("UI/Quest/Quest", Json.encode({questId = questId}))
end

function Controller:OnClickPlot1()
  local skipId = DataModel.ActivityCA.sequenceList[1].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  if DataModel.Plot1Type == DataModel.PlotType.AllNotFinish then
    Controller:SkipStation(skipCA.skipStationStart)
  end
  if DataModel.Plot1Type == DataModel.PlotType.AllFinish then
    Controller:SkipStation(skipCA.skipStationEnd)
  end
  if DataModel.Plot1Type == DataModel.PlotType.Quest then
    Controller:SkipQuest(DataModel.Plot1NowQuestId)
  end
end

function Controller:OnClickPlot2()
  local skipId = DataModel.ActivityCA.sequenceList[2].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  if DataModel.Plot2Type == DataModel.PlotType.AllNotFinish then
    Controller:SkipStation(skipCA.skipStationStart)
  end
  if DataModel.Plot2Type == DataModel.PlotType.AllFinish then
    Controller:SkipStation(skipCA.skipStationEnd)
  end
  if DataModel.Plot2Type == DataModel.PlotType.Quest then
    Controller:SkipQuest(DataModel.Plot2NowQuestId)
  end
end

local ResetGroupJoin = function()
  for k, v in pairs(View.Group_BlackTea.Group_Join) do
    if v ~= "Btn_Help" and v ~= "self" and v.self then
      v.self:SetActive(false)
    end
  end
end

function Controller:RefreshPlotShow(index, lastTime)
  local nowPlot, type
  local skipId = DataModel.ActivityCA.sequenceList[index].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  local questId
  if index == 1 then
    type = DataModel.Plot1Type
    questId = DataModel.Plot1NowQuestId
    nowPlot = View.Group_BlackTea.Group_Join.Group_Plot.Group_Plot1
  end
  if index == 2 then
    type = DataModel.Plot2Type
    questId = DataModel.Plot2NowQuestId
    nowPlot = View.Group_BlackTea.Group_Join.Group_Plot.Group_Plot2
  end
  if type == 4 then
    local name = PlayerData:GetFactoryData(skipCA.skipStationStart).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(string.format(GetText(80602585), name))
  end
  if type == 5 then
    local name = PlayerData:GetFactoryData(skipCA.skipStationEnd).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(string.format(GetText(80602585), name))
  end
  if type == 6 and questId then
    local name = PlayerData:GetFactoryData(questId).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(name)
  end
  if type == 2 and lastTime then
    nowPlot.Group_Time.self:SetActive(true)
    local time = TimeUtil:SecondToTable(lastTime)
    if time.day > 0 then
      nowPlot.Group_Time.Txt_Time:SetText(string.format(GetText(80602584), time.day, time.hour))
    else
      nowPlot.Group_Time.Txt_Time:SetText(string.format(GetText(80603020), time.hour, time.minute))
    end
  end
end

function Controller:RefreshPlot()
  DataModel.Plot1Type = DataModel.PlotType.NotEnabled
  DataModel.Plot2Type = DataModel.PlotType.NotEnabled
  DataModel.Plot1NowQuestId = nil
  DataModel.Plot2NowQuestId = nil
  local Group_Plot = View.Group_BlackTea.Group_Join.Group_Plot
  Group_Plot.self:SetActive(true)
  if TimeUtil:IsActive(DataModel.ActivityCA.startTime, DataModel.ActivityCA.endTime) then
    Group_Plot.Group_Finish.self:SetActive(false)
    local sequenceList = DataModel.ActivityCA.sequenceList
    Group_Plot.Group_Plot1.self:SetActive(sequenceList[1])
    if sequenceList[1] then
      Group_Plot.Group_Plot1.Group_Can.self:SetActive(false)
      Group_Plot.Group_Plot1.Group_Can.Img_RedPoint:SetActive(false)
      Group_Plot.Group_Plot1.Group_Time.self:SetActive(false)
      Group_Plot.Group_Plot1.Group_Quest.self:SetActive(false)
      local lastTime = TimeUtil:LastTime(sequenceList[1].startTime)
      if lastTime < 0 then
        DataModel.Plot1Type = DataModel.PlotType.Enabled
        if 0 < sequenceList[1].questId and Controller:QuestIsFinish(sequenceList[1].questId) == false then
          DataModel.Plot1Type = DataModel.PlotType.Lock
          Group_Plot.Group_Plot1.Group_Quest.self:SetActive(true)
          local questCA = PlayerData:GetFactoryData(sequenceList[1].questId)
          Group_Plot.Group_Plot1.Group_Quest.Txt_Quest:SetText(string.format(GetText(80602424), questCA.name))
        else
          local skipCA = PlayerData:GetFactoryData(sequenceList[1].skipId)
          local finishCount = 0
          local allCount = table.count(skipCA.skipQuestList)
          if skipCA.skipQuestList and 0 < table.count(skipCA.skipQuestList) then
            for k, v in pairs(skipCA.skipQuestList) do
              if v.id ~= -1 then
                if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.UnFinish then
                  DataModel.Plot1NowQuestId = v.id
                  DataModel.Plot1Type = DataModel.PlotType.Quest
                  break
                end
                if Controller:QuestIsFinish(v.id) then
                  finishCount = finishCount + 1
                end
              end
            end
          end
          if finishCount == 0 and DataModel.Plot1NowQuestId == nil then
            DataModel.Plot1Type = DataModel.PlotType.AllNotFinish
          end
          if finishCount == allCount then
            DataModel.Plot1Type = DataModel.PlotType.AllFinish
          end
          Controller:RefreshPlotShow(1, nil)
        end
      else
        DataModel.Plot1Type = DataModel.PlotType.NotEnabled
        Controller:RefreshPlotShow(1, lastTime)
      end
    end
    Group_Plot.Group_Plot2.self:SetActive(sequenceList[2])
    if sequenceList[2] then
      Group_Plot.Group_Plot2.Group_Can.self:SetActive(false)
      Group_Plot.Group_Plot2.Group_Can.Img_RedPoint:SetActive(false)
      Group_Plot.Group_Plot2.Group_Time.self:SetActive(false)
      Group_Plot.Group_Plot2.Group_Quest.self:SetActive(false)
      local lastTime = TimeUtil:LastTime(sequenceList[2].startTime)
      if lastTime < 0 then
        DataModel.Plot2Type = DataModel.PlotType.Enabled
        if 0 < sequenceList[2].questId and Controller:QuestIsFinish(sequenceList[2].questId) == false then
          DataModel.Plot2Type = DataModel.PlotType.Lock
          Group_Plot.Group_Plot2.Group_Quest.self:SetActive(true)
          local questCA = PlayerData:GetFactoryData(sequenceList[2].questId)
          Group_Plot.Group_Plot2.Group_Quest.Txt_Quest:SetText(string.format(GetText(80602424), questCA.name))
        else
          local skipCA = PlayerData:GetFactoryData(sequenceList[2].skipId)
          local finishCount = 0
          local allCount = table.count(skipCA.skipQuestList)
          if skipCA.skipQuestList and 0 < table.count(skipCA.skipQuestList) then
            for k, v in pairs(skipCA.skipQuestList) do
              if v.id ~= -1 then
                if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.UnFinish then
                  DataModel.Plot2NowQuestId = v.id
                  DataModel.Plot2Type = DataModel.PlotType.Quest
                  break
                end
                if Controller:QuestIsFinish(v.id) then
                  finishCount = finishCount + 1
                end
              end
            end
          end
          if finishCount == 0 and DataModel.Plot2NowQuestId == nil then
            DataModel.Plot2Type = DataModel.PlotType.AllNotFinish
          end
          if finishCount == allCount then
            DataModel.Plot2Type = DataModel.PlotType.AllFinish
          end
          Controller:RefreshPlotShow(2, nil)
        end
      else
        DataModel.Plot2Type = DataModel.PlotType.NotEnabled
        Controller:RefreshPlotShow(2, lastTime)
      end
    end
  else
    Group_Plot.Group_Finish.self:SetActive(true)
    Group_Plot.Group_Plot1.self:SetActive(false)
    Group_Plot.Group_Plot2.self:SetActive(false)
    local lastTime = TimeUtil:LastTime(DataModel.LeftActivityCA.endTime)
    local time = TimeUtil:SecondToTable(lastTime)
    if 0 < time.day then
      Group_Plot.Group_Finish.Txt_Time:SetText(string.format(GetText(80602423), time.day, time.hour))
    else
      Group_Plot.Group_Finish.Txt_Time:SetText(string.format(GetText(80602689), time.hour, time.minute))
    end
  end
end

function Controller:RefreshLeftRedState()
  local rowLeft = DataModel.LeftList[tonumber(DataModel.ChooseLeftIndex)]
  local elementLeft = View.Group_List.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.ChooseLeftIndex - 1)
  local Btn_Tab = elementLeft.Btn_Tab
  Btn_Tab.Img_Red:SetActive(DataModel.GetLeftListRedState(rowLeft.tagCA.tagName))
end

function Controller:RefreshCard()
  DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(DataModel.ActivityCA.activityCardPack)
  View.Group_BlackTea.Group_Join.Group_Card.self:SetActive(true)
  View.Group_BlackTea.Group_Join.Group_Card.Img_RedPoint:SetActive(DataModel.CardPackInfo.extraCardStatus == 1)
  View.Group_BlackTea.Group_Join.Group_Card.Txt_Num:SetText(string.format(GetText(80603017), DataModel.CardPackInfo.ownCount, DataModel.CardPackInfo.allCount))
end

function Controller:RefreshQuest()
  View.Group_BlackTea.Group_Join.Group_Quest.self:SetActive(false)
  if TimeUtil:IsActive(DataModel.LeftActivityCA.startTime, DataModel.LeftActivityCA.endTime) then
    View.Group_BlackTea.Group_Join.Group_Quest.self:SetActive(true)
    local finishNum, totalNum = AchievementDataModel.GetProgressInfo()
    View.Group_BlackTea.Group_Join.Group_Quest.Txt_Num:SetText(math.ceil(finishNum / totalNum * 100) .. "%")
    View.Group_BlackTea.Group_Join.Group_Quest.Group_Can.Img_RedPoint:SetActive(DataModel.GetAchievementRed())
  end
end

function Controller:RefreshBuff()
  if TimeUtil:IsActive(DataModel.ActivityCA.startTime, DataModel.ActivityCA.endTime) == false then
    return
  end
  local StageInfo = ServerProgressDataModel.GetCurStageInfo()
  local cfg = StageInfo.cfg
  if cfg then
    View.Group_BlackTea.Group_Join.Group_Buff.self:SetActive(true)
    local Group_Buff = View.Group_BlackTea.Group_Join.Group_Buff
    local buyIcon = cfg.buyPng
    local buyNum = cfg.buyNum == 0 and "" or string.format(GetText(80602624), cfg.buyNum)
    Group_Buff.Group_Buy.Img_Bg:SetSprite(buyIcon)
    Group_Buff.Group_Buy.Txt_Num:SetText(buyNum)
    local revenueIcon = cfg.revenuePng
    local revenueNum = cfg.revenueNum == 0 and "" or string.format(GetText(80602625), cfg.revenueNum)
    Group_Buff.Group_Revenue.Img_Bg:SetSprite(revenueIcon)
    Group_Buff.Group_Revenue.Txt_Num:SetText(revenueNum)
  end
end

function Controller:RefreshBlackTeaJoinPage()
  local Group_BlackTea = View.Group_BlackTea
  Group_BlackTea.Group_NotJoin.self:SetActive(false)
  local Group_Join = View.Group_BlackTea.Group_Join
  Group_Join.self:SetActive(true)
  DataModel.BlackTeaType = DataModel.BlackTeaTypeList.NotFinish
  ResetGroupJoin()
  Group_Join.Btn_Help.self:SetActive(true)
  Group_Join.Btn_Help.Txt_:SetText("活动详情")
  if DataModel.ActivityCA.activityStoreList and table.count(DataModel.ActivityCA.activityStoreList) > 0 then
    Group_Join.Group_Coin.self:SetActive(true)
    if DataModel.ActivityCA.activityStoreList[1].id and PlayerData:GetFactoryData(DataModel.ActivityCA.activityStoreList[1].id) then
      local ca = PlayerData:GetFactoryData(DataModel.ActivityCA.activityStoreList[1].id)
      if ca.currencyShow and 0 < table.count(ca.currencyShow) then
        for k, v in pairs(ca.currencyShow) do
          if tonumber(v.id) == 11400231 then
            local currencyCA = PlayerData:GetFactoryData(v.id)
            Group_Join.Group_Coin.Txt_Num:SetText(PlayerData:GetGoodsById(currencyCA.id).num)
            Group_Join.Group_Coin.Img_Icon:SetSprite(currencyCA.buyPath)
            DataModel.CoinId = currencyCA.id
          end
        end
      end
    end
  end
  Group_Join.Group_StageAll.self:SetActive(true)
  Group_Join.Group_StageAll.Group_Can.Img_RedPoint:SetActive(ServerProgressDataModel.GetRedPointState())
  Group_Join.Group_StageOne.self:SetActive(true)
  Group_Join.Group_StageOne.Group_Can.Img_RedPoint:SetActive(PersonalProgressDataModel.GetRedPointState())
  Group_Join.Group_Store.self:SetActive(true)
  Controller:RefreshQuest()
  Controller:RefreshCard()
  Controller:RefreshBuff()
  Controller:RefreshPlot()
end

function Controller:Open_Group_BlackTea(row)
  local Group_BlackTea = View.Group_BlackTea
  Group_BlackTea.Group_Time.self:SetActive(false)
  Group_BlackTea.Group_Join.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Preview.self:SetActive(false)
  if row.activeCA.isTime == true then
    Group_BlackTea.Group_NotJoin.self:SetActive(true)
    Group_BlackTea.Group_NotJoin.Group_Add.self:SetActive(true)
    if row.activeCA.rewardPreviewList and table.count(row.activeCA.rewardPreviewList) > 0 then
      DataModel.NotJoinReward = {}
      for k, v in pairs(row.activeCA.rewardPreviewList) do
        table.insert(DataModel.NotJoinReward, v)
      end
      Group_BlackTea.Group_NotJoin.Group_Preview.self:SetActive(true)
      Group_BlackTea.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(table.count(row.activeCA.rewardPreviewList))
      Group_BlackTea.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
    end
    local timeStart = TimeUtil:GetTimeTable(row.activeCA.startTime)
    local timeEnd = TimeUtil:GetTimeTable(row.activeCA.endTime)
    local a_1 = timeStart.year .. "/" .. timeStart.month .. "/" .. timeStart.day
    local b_1 = timeStart.hour .. ":" .. timeStart.minute
    local a_2 = timeEnd.year .. "/" .. timeEnd.month .. "/" .. timeEnd.day
    local b_2 = timeEnd.hour .. ":" .. timeEnd.minute
    local str = string.format(GetText(80602405), a_1, b_1, a_2, b_2)
    View.Group_BlackTea.Group_Time.Txt_EndTime:SetText(str)
    Group_BlackTea.Group_Time.self:SetActive(true)
    local isAdd = PlayerData:GetActivityAct(row.id)
    if TimeUtil:IsActive(row.activeCA.startTime, row.activeCA.endTime) then
      local lastTime = TimeUtil:LastTime(row.activeCA.endTime)
      local time = TimeUtil:SecondToTable(lastTime)
      if isAdd == false then
        if row.activeCA.questId ~= -1 and Controller:QuestIsFinish(row.activeCA.questId) == false then
          DataModel.BlackTeaType = DataModel.BlackTeaTypeList.Lock
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(true)
          local questCA = PlayerData:GetFactoryData(row.activeCA.questId)
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Quest:SetText(string.format(GetText(80602424), questCA.name))
          if 0 < time.day then
            Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Time:SetText(string.format(GetText(80602586), time.day))
          end
          return
        end
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.self:SetActive(true)
        if 0 < time.day then
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.Txt_Time:SetText(string.format(GetText(80602586), time.day))
        end
        DataModel.BlackTeaType = DataModel.BlackTeaTypeList.NotEnabled
        return
      end
      Controller:RefreshBlackTeaJoinPage()
    else
      Group_BlackTea.Group_NotJoin.self:SetActive(true)
      if TimeUtil:IsActive(row.startTime, row.endTime) then
        if isAdd == false then
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.self:SetActive(true)
          local lastTime = TimeUtil:LastTime(row.endTime)
          local time = TimeUtil:SecondToTable(lastTime)
          if 0 < time.day then
            Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText(string.format(GetText(80602423), time.day, time.hour))
          else
            Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText(string.format(GetText(80602689), time.hour, time.minute))
          end
        else
          Group_BlackTea.Group_NotJoin.self:SetActive(false)
          Controller:RefreshBlackTeaJoinPage()
        end
      else
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText("")
      end
    end
  end
end

function Controller:NotJoinRewardSetElemnt(element, elementIndex)
  local row = DataModel.NotJoinReward[elementIndex]
  CommonItem:SetItem(element.Group_Item, row)
  element.Group_Item.Btn_Item:SetClickParam(row.id)
end

function Controller:NotJoinRewardClickElemnt(id)
  CommonTips.OpenPreRewardDetailTips(id)
end

function Controller:OpenRightPage()
  local row = DataModel.LeftList[DataModel.ChooseLeftIndex]
  DataModel.LeftActivityCA = row
  DataModel.ActivityCA = row.activeCA
  UIManager:LoadSplitPrefab(View, "UI/Activity/ActivityMain", row.activeCA.showUI)
  View[row.activeCA.showUI].self:SetActive(true)
  if row.activeCA.showUI ~= "" then
    if row.activeCA.showUI == "Group_BlackTea" then
      Controller:Open_Group_BlackTea(row)
    end
    if row.activeCA.showUI == "Group_SignIn" then
      Controller:Open_Group_SignIn(row)
    end
  end
end

function Controller:ClickLeftActive(index)
  if DataModel.ChooseLeftIndex and DataModel.ChooseLeftIndex == index then
    return
  end
  if DataModel.ChooseLeftIndex and View.Group_List.ScrollGrid_List.grid[DataModel.ChooseLeftIndex] then
    local old_element = View.Group_List.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.ChooseLeftIndex - 1)
    old_element.Btn_Tab.Img_Selected:SetActive(false)
    old_element.Btn_Tab.Img_Unselected:SetActive(true)
    local old_row = DataModel.LeftList[DataModel.ChooseLeftIndex]
    View[old_row.activeCA.showUI].self:SetActive(false)
  end
  DataModel.ChooseLeftIndex = index
  local row = DataModel.LeftList[index]
  View.Img_BackGround:SetSprite(row.activeCA.bgPath)
  local element = View.Group_List.ScrollGrid_List.grid[index]
  element.Btn_Tab.Img_Selected:SetActive(true)
  element.Btn_Tab.Img_Unselected:SetActive(false)
  Controller:OpenRightPage()
end

return Controller
