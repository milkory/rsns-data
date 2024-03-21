local View = require("UIActivityAchievement/UIActivityAchievementView")
local DataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local Controller = require("UIActivityMain/BlackTeaActivityController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ActivityAchievement_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ActivityAchievement_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ActivityAchievement_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ActivityAchievement_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ActivityAchievement_Group_DownTrade_ScrollGrid_TypeList_SetGrid = function(element, elementIndex)
    local info = DataModel.achieveTradeData[elementIndex]
    local profit = 0
    if info.typeEnum == "addProfit" then
      profit = DataModel.addProfit
    elseif info.typeEnum == "onceProfit" then
      profit = DataModel.onceProfit
    end
    element.Group_TypeContent.Txt_Num:SetText(NumThousandsSplit(profit))
    element.Img_Icon:SetSprite(info.icon)
    element.Group_TypeContent.Txt_SeriesName:SetText(info.seriesName)
    local targetNum = NumThousandsSplit(info.targetNum)
    local des = string.format("红茶利润达到%s可获得活动卡牌", targetNum)
    element.Group_TypeContent.Txt_SeriesName.Txt_ThirdMissionDes:SetText(des)
    element.Group_TypeContent.Img_ProgressBarBG.Img_ProgressBar:SetFilledImgAmount(profit / info.targetNum)
    local txt = PlayerData:GetFactoryData(80603014, "TextFactory").text
    element.Group_TypeContent.Txt_SeriesName.Txt_ThirdMissionDes:SetText(txt)
    element.StaticGrid_Mission.grid.self:SetParentParam(elementIndex)
    local cfg = PlayerData:GetFactoryData(info.typeId, "ListFactory")
    element.StaticGrid_Mission.grid.self:SetDataCount(#cfg.achievementList)
    element.StaticGrid_Mission.grid.self:RefreshAllElement()
  end,
  ActivityAchievement_Group_DownTrade_ScrollGrid_TypeList_Group_Item_StaticGrid_Mission_SetGrid = function(element, elementIndex)
    local parentInfo = DataModel.achieveTradeData[tonumber(element.ParentParam)]
    local cfg = PlayerData:GetFactoryData(parentInfo.typeId, "ListFactory")
    local info = cfg.achievementList[elementIndex]
    element.Img_pic:SetSprite(info.icon)
    element.Img_English:SetSprite(info.englishPic)
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    element.Txt_Name:SetText(questCfg.story)
    element.Txt_Num:SetText(NumThousandsSplit(questCfg.num))
    local state = PlayerData.GetQuestState(info.id)
    element.Group_Common:SetActive(state == EnumDefine.EQuestState.Lock or state == EnumDefine.EQuestState.UnFinish)
    element.Btn_Get:SetActive(state == EnumDefine.EQuestState.Finish)
    element.Btn_Get:SetClickParam(info.id)
    element.Group_Completed:SetActive(state == EnumDefine.EQuestState.Receive)
    local param = element.ParentParam .. "_" .. elementIndex
    element.StaticGrid_Rewareds.grid.self:SetParentParam(param)
    element.StaticGrid_Rewareds.grid.self:SetDataCount(#questCfg.rewardsList)
    element.StaticGrid_Rewareds.grid.self:RefreshAllElement()
  end,
  ActivityAchievement_Group_DownTrade_ScrollGrid_TypeList_Group_Item_StaticGrid_Mission_Group_Mission_StaticGrid_Rewareds_SetGrid = function(element, elementIndex)
    local parentParam = element.ParentParam
    local paramIndex = string.split(parentParam, "_")
    local parent1Info = DataModel.achieveTradeData[tonumber(paramIndex[1])]
    local cfg = PlayerData:GetFactoryData(parent1Info.typeId, "ListFactory")
    local parent2Info = cfg.achievementList[tonumber(paramIndex[2])]
    local questCfg = PlayerData:GetFactoryData(parent2Info.id, "QuestFactory")
    local info = questCfg.rewardsList[elementIndex]
    CommonItem:SetItem(element.Group_CommonItem, info)
    element.Group_CommonItem.Btn_Item:SetClickParam(info.id)
  end,
  ActivityAchievement_Group_DownTrade_ScrollGrid_TypeList_Group_Item_StaticGrid_Mission_Group_Mission_StaticGrid_Rewareds_Group_Rewards_Group_CommonItem_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  ActivityAchievement_Group_DownTrade_ScrollGrid_TypeList_Group_Item_StaticGrid_Mission_Group_Mission_Btn_Get_Click = function(btn, str)
    local state = PlayerData.GetQuestState(tonumber(str))
    if state ~= EnumDefine.EQuestState.Finish then
      return
    end
    Net:SendProto("quest.recv_rewards", function(json)
      btn.transform.parent:Find("Group_Completed").gameObject:SetActive(true)
      btn.gameObject:SetActive(false)
      local serverData = PlayerData.ServerData.quests.activity_achieve
      if serverData[str] then
        serverData[str].recv = TimeUtil:GetServerTimeStamp()
      end
      PlayerData.RefreshCardsData(json.reward)
      CommonTips.OpenShowItem(json.reward)
    end, str)
  end,
  ActivityAchievement_Group_DownBattle_StaticGrid_Mission_SetGrid = function(element, elementIndex)
    local info = DataModel.achieveBattleData[elementIndex]
    local state = PlayerData.GetQuestState(info.missionId)
    element.Img_BgLocked:SetActive(state == EnumDefine.EQuestState.Lock)
    element.Img_BgLocked:SetSprite(info.lockedBg)
    element.Img_BG:SetActive(state ~= EnumDefine.EQuestState.Lock)
    element.Img_BG:SetSprite(info.commonBg)
    element.Img_Icon:SetSprite(info.icon)
    element.Group_MissionName:SetActive(state ~= EnumDefine.EQuestState.Lock)
    local questCfg = PlayerData:GetFactoryData(info.missionId, "QuestFactory")
    element.Group_MissionName.Txt_MissionName:SetText(questCfg.name)
    element.Group_MissionNameLocked:SetActive(state == EnumDefine.EQuestState.Lock)
    local showCommon = state == EnumDefine.EQuestState.UnFinish or state == EnumDefine.EQuestState.Lock
    local lock = state == EnumDefine.EQuestState.Lock
    element.Group_Common:SetActive(showCommon)
    element.Group_Common.Txt_Common:SetActive(not lock)
    element.Group_Common.Txt_LockedDes:SetActive(lock)
    element.Group_Common.Txt_LockedDes:SetText(info.lockDes)
    element.Btn_Get:SetActive(state == EnumDefine.EQuestState.Finish)
    element.Btn_Get:SetClickParam(info.missionId)
    element.Group_Completed:SetActive(state == EnumDefine.EQuestState.Receive)
    element.StaticGrid_Rewards.grid.self:SetParentParam(elementIndex)
    element.StaticGrid_Rewards.grid.self:SetDataCount(#questCfg.rewardsList)
    element.StaticGrid_Rewards.grid.self:RefreshAllElement()
  end,
  ActivityAchievement_Group_DownBattle_StaticGrid_Mission_Group_BattleMission_StaticGrid_Rewards_SetGrid = function(element, elementIndex)
    local parentInfo = DataModel.achieveBattleData[tonumber(element.ParentParam)]
    local questCfg = PlayerData:GetFactoryData(parentInfo.missionId, "QuestFactory")
    local info = questCfg.rewardsList[elementIndex]
    local state = PlayerData.GetQuestState(parentInfo.missionId)
    local lock = state == EnumDefine.EQuestState.Lock
    element.Group_Locked:SetActive(lock)
    element.Group_CommonItem:SetActive(not lock)
    if not lock then
      CommonItem:SetItem(element.Group_CommonItem, info)
      element.Group_CommonItem.Btn_Item:SetClickParam(info.id)
    end
  end,
  ActivityAchievement_Group_DownBattle_StaticGrid_Mission_Group_BattleMission_Btn_Get_Click = function(btn, str)
    local state = PlayerData.GetQuestState(tonumber(str))
    if state ~= EnumDefine.EQuestState.Finish then
      return
    end
    Net:SendProto("quest.recv_rewards", function(json)
      btn.transform.parent:Find("Group_Completed").gameObject:SetActive(true)
      btn.gameObject:SetActive(false)
      local serverData = PlayerData.ServerData.quests.activity_achieve
      if serverData[str] then
        serverData[str].recv = TimeUtil:GetServerTimeStamp()
      end
      PlayerData.RefreshCardsData(json.reward)
      CommonTips.OpenShowItem(json.reward)
    end, str)
  end,
  ActivityAchievement_Group_TopRight_Group_Trade_Btn_Switch_Click = function(btn, str)
    local achieveType = tonumber(str)
    Controller.RefreshAchieve(achieveType)
  end,
  ActivityAchievement_Group_TopRight_Group_Battle_Btn_Switch_Click = function(btn, str)
    local achieveType = tonumber(str)
    Controller.RefreshAchieve(achieveType)
  end,
  ActivityAchievement_Group_DownBattle_StaticGrid_Mission_Group_BattleMission_StaticGrid_Rewards_Group_RewardsBattle_Group_CommonItem_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end
}
return ViewFunction
