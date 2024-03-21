local View = require("UIPersonalProgress/UIPersonalProgressView")
local DataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  PersonalProgress_Group_TopLeft_Btn_Server_Click = function(btn, str)
    View.self:CloseUI()
    UIManager:Open("UI/Activity/BlackTea/ServerProgress")
  end,
  PersonalProgress_Group_Right_ScrollGrid_ProgressList_SetGrid = function(element, elementIndex)
    local info = DataModel.allStage[elementIndex]
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    local state = PlayerData.GetQuestState(info.id)
    element.Img_BG.Group_Goal.Txt_Num:SetText(questCfg.num)
    element.Img_BG.Btn_Award.Img_Unable:SetActive(state == EnumDefine.EQuestState.Lock or state == EnumDefine.EQuestState.UnFinish)
    element.Img_BG.Btn_Award.Img_Finished:SetActive(state == EnumDefine.EQuestState.Receive)
    element.Img_BG.Btn_Award.Img_Able:SetActive(state == EnumDefine.EQuestState.Finish)
    element.Img_BG.Btn_Award:SetClickParam(elementIndex)
    element.Img_BG.StaticGrid_RewardList.grid.self:SetParentParam(elementIndex)
    element.Img_BG.StaticGrid_RewardList.grid.self:SetDataCount(#questCfg.rewardsList)
    element.Img_BG.StaticGrid_RewardList.grid.self:RefreshAllElement()
  end,
  PersonalProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_Btn_Award_Click = function(btn, str)
    local info = DataModel.allStage[tonumber(str)]
    local state = PlayerData.GetQuestState(info.id)
    if state ~= EnumDefine.EQuestState.Finish then
      return
    end
    Net:SendProto("quest.recv_rewards", function(json)
      btn.transform:Find("Img_Finished").gameObject:SetActive(true)
      btn.transform:Find("Img_Able").gameObject:SetActive(false)
      local serverData = PlayerData.ServerData.quests.activity_quests
      if serverData[tostring(info.id)] then
        serverData[tostring(info.id)].recv = TimeUtil:GetServerTimeStamp()
      end
      PlayerData.RefreshCardsData(json.reward)
      CommonTips.OpenShowItem(json.reward)
    end, info.id)
  end,
  PersonalProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_StaticGrid_RewardList_SetGrid = function(element, elementIndex)
    local info = DataModel.allStage[tonumber(element.ParentParam)]
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    local rewardInfo = questCfg.rewardsList[elementIndex]
    if rewardInfo then
      CommonItem:SetItem(element, rewardInfo)
      element.Btn_Item:SetClickParam(rewardInfo.id)
    end
  end,
  PersonalProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_StaticGrid_RewardList_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  PersonalProgress_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PersonalProgress_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  PersonalProgress_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  PersonalProgress_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
