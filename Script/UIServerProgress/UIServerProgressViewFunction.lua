local View = require("UIServerProgress/UIServerProgressView")
local DataModel = require("UIServerProgress/UIServerProgressDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ServerProgress_Group_TopLeft_Btn_Personal_Click = function(btn, str)
    View.self:CloseUI()
    UIManager:Open("UI/Activity/BlackTea/PersonalProgress")
  end,
  ServerProgress_Group_Right_ScrollGrid_ProgressList_SetGrid = function(element, elementIndex)
    local info = DataModel.allStage[elementIndex]
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    element.Img_BG.Group_Goal.Txt_Num:SetText(NumThousandsSplit(questCfg.num))
    local state = PlayerData.GetQuestState(info.id)
    element.Img_BG.Btn_Award.Img_Unable:SetActive(state == EnumDefine.EQuestState.Lock or state == EnumDefine.EQuestState.UnFinish)
    element.Img_BG.Btn_Award.Img_Finished:SetActive(state == EnumDefine.EQuestState.Receive)
    element.Img_BG.Btn_Award.Img_Able:SetActive(state == EnumDefine.EQuestState.Finish)
    element.Img_BG.Group_HomeSkill:SetActive(info.buff > 0)
    if info.buff > 0 then
      local buffCfg = PlayerData:GetFactoryData(info.buff, "HomeBuffFactory")
      element.Img_BG.Group_HomeSkill.Txt_Des:SetText(buffCfg.desc)
      local stageInfo = DataModel.GetStageInfo(questCfg.num)
      local txt = string.format(GetText(80602520), stageInfo.index)
      element.Img_BG.Group_HomeSkill.Txt_01:SetText(txt)
    end
    element.Img_BG.Btn_Award:SetClickParam(elementIndex)
    element.Img_BG.StaticGrid_RewardList.grid.self:SetParentParam(elementIndex)
    element.Img_BG.StaticGrid_RewardList.grid.self:SetDataCount(#questCfg.rewardsList)
    element.Img_BG.StaticGrid_RewardList.grid.self:RefreshAllElement()
  end,
  ServerProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_Btn_Award_Click = function(btn, str)
    local info = DataModel.allStage[tonumber(str)]
    local state = PlayerData.GetQuestState(info.id)
    if state ~= EnumDefine.EQuestState.Finish then
      return
    end
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    Net:SendProto("main.recv_activity", function(json)
      btn.transform:Find("Img_Finished").gameObject:SetActive(true)
      btn.transform:Find("Img_Able").gameObject:SetActive(false)
      PlayerData.RefreshCardsData(json.reward)
      PlayerData:RefreshActivityData(questCfg.correspondActivity, json.activity)
      CommonTips.OpenShowItem(json.reward)
    end, questCfg.correspondActivity, info.id)
  end,
  ServerProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_StaticGrid_RewardList_SetGrid = function(element, elementIndex)
    local info = DataModel.allStage[tonumber(element.ParentParam)]
    local questCfg = PlayerData:GetFactoryData(info.id, "QuestFactory")
    local rewardInfo = questCfg.rewardsList[elementIndex]
    if rewardInfo then
      CommonItem:SetItem(element, rewardInfo)
      element.Btn_Item:SetClickParam(rewardInfo.id)
    end
  end,
  ServerProgress_Group_Right_ScrollGrid_ProgressList_Group_Item_Img_BG_StaticGrid_RewardList_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  ServerProgress_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ServerProgress_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ServerProgress_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ServerProgress_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ServerProgress_Group_Left_Img_Door_Btn_Buff_Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/BuffTips")
  end
}
return ViewFunction
