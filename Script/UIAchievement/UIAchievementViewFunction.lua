local View = require("UIAchievement/UIAchievementView")
local DataModel = require("UIAchievement/UIAchievementDataModel")
local CommonItem = require("Common/BtnItem")
local groupSelectItem
local redCallBack = {}
local ClearObj = function()
  groupSelectItem = nil
  redCallBack = {}
end
local RefreshAchiStage = function()
  DataModel.nowAchiStage = DataModel.nowAchiStage > DataModel.maxAchiStage and DataModel.maxAchiStage or DataModel.nowAchiStage
  local cfg = PlayerData:GetFactoryData(DataModel.achieveGroupList[1].id).accumulateList[DataModel.nowAchiStage]
  View.Group_JieDuan.Img_Icon:SetSprite(cfg.png)
  View.Group_JieDuan.Txt_Name:SetText(cfg.name)
  View.Group_JieDuan.Txt_JieDuan:SetText(cfg.stageName)
  local nowProcess = MathEx.Clamp(PlayerData.ServerData.quests.accumulate_rewards.sum_cnt, 0, cfg.sumCount)
  View.Group_JieDuan.Group_JinDu.Txt_JinDu:SetText(math.floor(nowProcess / cfg.sumCount * 100) .. "%")
  View.Group_JieDuan.Group_JinDu.Img_JinDu:SetWidth(nowProcess / cfg.sumCount * DataModel.stageBarWidth)
  View.Group_JieDuan.Img_1.Txt_Num:SetText(PlayerData.ServerData.quests.accumulate_rewards.sum_cnt)
  View.Group_JieDuan.Img_2.Txt_Num:SetText(PlayerData.achieveList.finishCnt)
end
local RefreshAchieveList = function(index)
  View.Group_AchievePoint:SetActive(index == 1)
  View.Group_AchieveQuest:SetActive(index ~= 1)
  DataModel:UpdateAchieveData(index)
  if index == 1 then
    View.Group_Left.ScrollGrid_Left.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_Left.ScrollGrid_Left.grid.self:SetDataCount(#DataModel.achieveGroupList)
    View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
    View.Group_AchievePoint.ScrollGrid_AchievePoint.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_AchievePoint.ScrollGrid_AchievePoint.grid.self:SetDataCount(#DataModel.nowList)
    View.Group_AchievePoint.ScrollGrid_AchievePoint.grid.self:RefreshAllElement()
  else
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.nowList)
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self:RefreshAllElement()
  end
  RefreshAchiStage()
end
local RecvAchieveReward = function(id, achieveType)
  DataModel:SetPlayerAchieveData(id, achieveType)
  local achieveGroupID
  DataModel.quesAchiList[DataModel.nowListIndex] = nil
  DataModel:UpdateAchieveData(DataModel.nowListIndex)
  if achieveType == 1 then
    achieveGroupID = 1
    View.Group_AchievePoint.ScrollGrid_AchievePoint.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_AchievePoint.ScrollGrid_AchievePoint.grid.self:RefreshAllElement()
  else
    local config = PlayerData:GetFactoryData(id)
    DataModel:UpdataAchevePoint(config.achievePoint)
    achieveGroupID = config.achieveList
    RefreshAchiStage()
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.nowList)
    View.Group_AchieveQuest.ScrollGrid_Level.grid.self:RefreshAllElement()
  end
  local nodeName = RedpointTree.NodeNames["AchieveGroup" .. achieveGroupID] .. "|" .. id
  RedpointTree:ChangeRedpointCnt(nodeName, -1)
end
local SetRedCall = function(redName, key, obj)
  if not RedpointTree:SearchNodeCallBack() then
    redCallBack[redName] = function(redpointCnt)
      if obj.name == key then
        obj:SetActive(0 < redpointCnt)
      end
    end
    RedpointTree:SetCallBack(redName, key, redCallBack[redName])
  end
  obj:SetActive(RedpointTree:GetRedpointCnt(redName) > 0)
end
local ViewFunction = {
  Achievement_Group_AchievePoint_ScrollGrid_AchievePoint_SetGrid = function(element, elementIndex)
    local data = DataModel.nowList[elementIndex]
    element.Img_Icon:SetSprite(data.png)
    element.Txt_Name:SetText(data.name)
    local nowProcess = math.floor(MathEx.Clamp(PlayerData.ServerData.quests.accumulate_rewards.sum_cnt, 0, data.sumCount))
    element.Group_JinDu.Txt_JinDu:SetText(string.format("%d/%d", nowProcess, data.sumCount))
    element.Group_JinDu.Img_JinDu:SetWidth(nowProcess / data.sumCount * DataModel.pointItemBarWidth)
    element.Txt_Dec:SetText(string.format(GetText(80601042), data.sumCount))
    local achieveRewardList = PlayerData:GetFactoryData(DataModel.nowList[elementIndex].id).achieveRewardList
    DataModel.rewardList = achieveRewardList
    element.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.ScrollGrid_Reward.grid.self:SetDataCount(#achieveRewardList)
    element.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.ScrollGrid_Reward.grid.self:MoveToTop()
    element.Group_LQ.Btn_LQ:SetClickParam(DataModel.nowList[elementIndex].id)
    local achiData = PlayerData.achieveList[DataModel.nowList[elementIndex].id] or {
      status = 1,
      recvTime = 0,
      pcnt = 0
    }
    element.Group_LQ.Img_Wei:SetActive(achiData.status == 1)
    element.Group_LQ.Btn_LQ:SetActive(achiData.status == 2)
    element.Group_LQ.Img_Yi:SetActive(achiData.status == 0)
  end,
  Achievement_Group_AchievePoint_Btn_Icon_Click = function(btn, str)
  end,
  Achievement_Group_AchievePoint_Group_Tips_Btn_Close_Click = function(btn, str)
  end,
  Achievement_Group_AchieveQuest_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    local itemConfig = PlayerData:GetFactoryData(DataModel.nowList[elementIndex].id)
    DataModel.rewardList = itemConfig.rewardsList
    element.Txt_Name:SetText(itemConfig.name)
    element.Txt_Dec:SetText(itemConfig.story)
    element.Img_1.Txt_Num:SetText(itemConfig.achievePoint)
    local achiData = PlayerData.achieveList[DataModel.nowList[elementIndex].id] or {
      status = 1,
      recvTime = 0,
      pcnt = 0
    }
    element.Group_LQ.Img_Wei:SetActive(achiData.status == 1)
    element.Group_LQ.Btn_LQ:SetActive(achiData.status == 2)
    element.Group_LQ.Img_Yi:SetActive(achiData.status == 0)
    element.Group_Time:SetActive(achiData.status ~= 1)
    if achiData.status ~= 1 then
      element.Group_Time.Txt_Time:SetText(os.date(GetText(80600695), achiData.completed_ts or 0))
    end
    local nowProcess = math.floor(MathEx.Clamp(achiData.pcnt, 0, itemConfig.num))
    local ahieve_num = itemConfig.num
    if DataModel.travel_data[DataModel.nowList[elementIndex].id] then
      nowProcess = math.floor(nowProcess * DataModel.disRatio)
      ahieve_num = math.floor(ahieve_num * DataModel.disRatio)
    end
    element.Group_JinDu.Txt_JinDu:SetText(string.format("%d/%d", nowProcess, ahieve_num))
    element.Group_JinDu.Img_JinDu:SetWidth(nowProcess / ahieve_num * DataModel.questItemBarWidth)
    element.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.ScrollGrid_Reward.grid.self:SetDataCount(#itemConfig.rewardsList)
    element.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.ScrollGrid_Reward.grid.self:MoveToTop()
    element.Group_LQ.Btn_LQ:SetClickParam(DataModel.nowList[elementIndex].id)
    local achiCfg = PlayerData:GetFactoryData(99900041).achieveList[itemConfig.achieveList - 1]
    element.Img_Icon:SetSprite(achiCfg.pngLittle)
  end,
  Achievement_Group_AchieveQuest_ScrollGrid_Level_Group_Item_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local index = tonumber(element.ParentParam)
    local itemConfig = PlayerData:GetFactoryData(DataModel.nowList[index].id)
    local rewardList = itemConfig.rewardsList
    CommonItem:SetItem(element.Group_Item, {
      id = rewardList[elementIndex].id,
      num = rewardList[elementIndex].num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
  end,
  Achievement_Group_AchieveQuest_ScrollGrid_Level_Group_Item_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  Achievement_Group_AchieveQuest_ScrollGrid_Level_Group_Item_Group_LQ_Btn_LQ_Click = function(btn, str)
    local id = tonumber(str)
    if PlayerData.achieveList[id].status == 2 then
      Net:SendProto("quest.recv_rewards", function(json)
        RecvAchieveReward(id, 2)
        CommonTips.OpenShowItem(json.reward)
      end, id)
    end
  end,
  Achievement_Group_Left_ScrollGrid_Left_SetGrid = function(element, elementIndex)
    local data = DataModel.achieveGroupList[elementIndex]
    if data == nil then
      return
    end
    element.Img_NotSelect.Txt_Name:SetText(data.name)
    element.Img_Select.Txt_Name:SetText(data.name)
    element.Btn_:SetClickParam(elementIndex)
    element.Img_Select.Img_Icon:SetSprite(data.pngSelect)
    element.Img_NotSelect.Img_Icon:SetSprite(data.pngNotSelect)
    if DataModel.nowListIndex == elementIndex then
      groupSelectItem = element.Img_Select.gameObject
      element.Img_Select:SetActive(true)
    else
      element.Img_Select:SetActive(false)
    end
    local redName = "AchieveGroup" .. elementIndex
    if element.Img_Red then
      element.Img_Red.gameObject.name = redName
    end
    if not RedpointTree.NodeNames[redName] then
      RedpointTree.NodeNames[redName] = "Root|AchievementUI|Group" .. elementIndex
      RedpointTree:InsertNode(RedpointTree.NodeNames[redName])
    end
    SetRedCall(RedpointTree.NodeNames[redName], redName, element[redName] or element.Img_Red)
  end,
  Achievement_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    ClearObj()
    UIManager:GoBack()
  end,
  Achievement_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    ClearObj()
    UIManager:GoHome()
  end,
  Achievement_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Achievement_Group_Left_ScrollGrid_Left_Group_Item_Btn__Click = function(btn, str)
    local index = tonumber(str)
    if DataModel.nowListIndex ~= index then
      groupSelectItem:SetActive(false)
      groupSelectItem = btn.transform.parent:Find("Img_Select").gameObject
      groupSelectItem:SetActive(true)
      RefreshAchieveList(index)
      local aniName = index == 1 and "Switch_Point" or "Switch_Quest"
      View.self:PlayAnimOnce(aniName)
    end
  end,
  Achievement_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Achievement_Group_AchievePoint_ScrollGrid_AchievePoint_Group_Item_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local index = tonumber(element.ParentParam)
    local rewardList = PlayerData:GetFactoryData(DataModel.nowList[index].id).achieveRewardList
    CommonItem:SetItem(element.Group_Item, {
      id = rewardList[elementIndex].id,
      num = rewardList[elementIndex].num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
  end,
  Achievement_Group_AchievePoint_ScrollGrid_AchievePoint_Group_Item_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = itemId})
  end,
  Achievement_Group_AchievePoint_ScrollGrid_AchievePoint_Group_Item_Group_LQ_Btn_LQ_Click = function(btn, str)
    local id = tonumber(str)
    local index = 0
    local configID = PlayerData:GetFactoryData(99900041).achievePointList[1].id
    local pointList = PlayerData:GetFactoryData(configID).accumulateList
    for i, v in ipairs(pointList) do
      if v.id == id then
        index = i - 1
        break
      end
    end
    Net:SendProto("quest.accumulate", function(json)
      RecvAchieveReward(id, 1)
      CommonTips.OpenShowItem(json.reward)
    end, index)
  end,
  RefreshAchieveList = RefreshAchieveList
}
return ViewFunction
