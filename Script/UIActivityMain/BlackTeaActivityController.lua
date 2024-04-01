local Controller = {}
local personalView = require("UIPersonalProgress/UIPersonalProgressView")
local personalDataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local serverView = require("UIServerProgress/UIServerProgressView")
local serverDataModel = require("UIServerProgress/UIServerProgressDataModel")
local buffView = require("UIBuffTips/UIBuffTipsView")
local buffDataModel = require("UIBuffTips/UIBuffTipsDataModel")
local achieveView = require("UIActivityAchievement/UIActivityAchievementView")
local achieveDataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")

function Controller.RefreshPersonalStage()
  local num = personalDataModel.curNum
  personalView.Group_Left.Group_Sum.Txt_Num:SetText(NumThousandsSplit(num))
  personalView.Group_Right.ScrollGrid_ProgressList.grid.self:SetDataCount(#personalDataModel.allStage)
  personalView.Group_Right.ScrollGrid_ProgressList.grid.self:RefreshAllElement()
  personalView.Group_TopLeft.Btn_Server.Img_RedPoint:SetActive(serverDataModel.GetRedPointState())
end

function Controller.RefreshServerStage()
  local num = serverDataModel.curNum
  local finalNum = serverDataModel.finalTargetNum
  local nextStage = serverDataModel.GetNextStageInfo()
  local questCfg = PlayerData:GetFactoryData(nextStage.cfg.id, "QuestFactory")
  local nextNum = questCfg.num
  serverView.Group_Left.Group_Sum.Txt_Num:SetText(NumThousandsSplit(num))
  local curStageNum = PlayerData:GetFactoryData(serverDataModel.curStageCfg.id, "QuestFactory").num
  serverView.Group_Left.Group_ShowNum:SetActive(num < finalNum)
  serverView.Group_Left.Group_ShowNum.Group_Present.Txt_Num:SetText(NumThousandsSplit(curStageNum))
  serverView.Group_Left.Group_ShowNum.Group_Next.Group_Num.Txt_Num:SetText(NumThousandsSplit(nextNum))
  local ratio = string.format("%.3f", num / nextNum)
  serverView.Group_Left.Group_Bar.Img_Line:SetFilledImgAmount(0.1 + 0.8 * tonumber(ratio))
  serverView.Group_Right.ScrollGrid_ProgressList.grid.self:SetDataCount(#serverDataModel.allStage)
  serverView.Group_Right.ScrollGrid_ProgressList.grid.self:RefreshAllElement()
  serverView.Group_TopLeft.Btn_Personal.Img_RedPoint:SetActive(personalDataModel.GetRedPointState())
  serverView.Group_Left.Txt_Stage.Txt_Num:SetText(serverDataModel.curStageIndex)
  serverView.Group_Left.Txt_Stage.Txt_Max:SetActive(num >= finalNum)
  local stageCfg = serverDataModel.curStageCfg
  local activityColor = "#FFFFFF"
  local unActivityColor = "#9B9B9B"
  local unActivityTxt = PlayerData:GetFactoryData(80602606, "TextFactory").text
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local inTime = TimeUtil:IsActive(activityCfg.startTime, activityCfg.endTime)
  local buyTxtNum = inTime and stageCfg.buyNum > 0 and stageCfg.buyNum .. "%" or unActivityTxt
  local buyColor = inTime and stageCfg.buyNum > 0 and activityColor or unActivityColor
  serverView.Group_Left.Group_Buff.Group_Buy.Txt_Des:SetColor(buyColor)
  serverView.Group_Left.Group_Buff.Group_Buy.Txt_State:SetColor(buyColor)
  serverView.Group_Left.Group_Buff.Group_Buy.Txt_State:SetText(buyTxtNum)
  local taxTxtNum = 0 < stageCfg.revenueNum and stageCfg.revenueNum .. "%" or unActivityTxt
  local taxColor = 0 < stageCfg.revenueNum and activityColor or unActivityColor
  serverView.Group_Left.Group_Buff.Group_Tax.Txt_Des:SetColor(taxColor)
  serverView.Group_Left.Group_Buff.Group_Tax.Txt_State:SetColor(taxColor)
  serverView.Group_Left.Group_Buff.Group_Tax.Txt_State:SetText(taxTxtNum)
  serverView.Group_Left.Group_Buff.Group_Buy.Img_Icon:SetSprite(stageCfg.buyIcon)
  serverView.Group_Left.Group_Buff.Group_Tax.Img_Icon:SetSprite(stageCfg.revenueIcon)
  local parent = serverView.Group_Left.Img_Door.Img_Table
  for i = 1, parent.transform.childCount do
    local child = parent.transform:GetChild(i - 1)
    child:Find("Img_Mask").gameObject:SetActive(i >= serverDataModel.curStageIndex)
  end
end

function Controller.RefreshBuffStage()
  local num = serverDataModel.GetCurNum()
  local finalNum = buffDataModel.finalTargetNum
  buffView.Group_Bar.Img_Stage.Txt_Num:SetText(buffDataModel.curStageIndex)
  buffView.Group_Bar.Group_Bar.Group_Num.Txt_Num:SetText(NumThousandsSplit(num))
  local nextStage = serverDataModel.GetNextStageInfo()
  local questCfg = PlayerData:GetFactoryData(nextStage.cfg.id, "QuestFactory")
  local nextNum = questCfg.num
  buffView.Group_Bar.Group_Bar.Group_RightTxt.Group_Next.Group_Num.Txt_Num:SetText(NumThousandsSplit(nextNum))
  buffView.Group_Bar.Group_Bar.Img_Slider.Img_Bar:SetFilledImgAmount(num / nextNum)
  buffView.Group_Bar.Group_Bar.Group_RightTxt.Group_Max:SetActive(num >= finalNum)
  buffView.Group_Bar.Group_Bar.Group_RightTxt.Group_Next:SetActive(num < finalNum)
  buffView.Group_Bar.Group_Bar.Group_NextStage.Group_Max:SetActive(num >= finalNum)
  buffView.Group_Bar.Group_Bar.Group_NextStage.Group_Next:SetActive(num < finalNum)
  buffView.Group_Bar.Group_Bar.Group_NextStage.Group_Next.Img_Icon.Txt_Level:SetText(nextStage.index)
  buffView.StaticGrid_Stage.grid.self:SetDataCount(#buffDataModel.allBuffStage)
  buffView.StaticGrid_Stage.grid.self:RefreshAllElement()
  local parent = buffView.Img_Door.Group_Dessert
  for i = 1, parent.transform.childCount do
    local child = parent.transform:GetChild(i - 1)
    child:Find("Img_Mask").gameObject:SetActive(i >= buffDataModel.curStageIndex)
  end
end

function Controller.RefreshAchieve(achieveType)
  if achieveDataModel.achieveType == achieveType then
    return
  end
  achieveDataModel.achieveType = achieveType
  local showTrade = achieveType == achieveDataModel.AchieveType.Trade
  local showBattle = achieveType == achieveDataModel.AchieveType.Battle
  achieveView.Group_TopRight.Group_Trade.Btn_Switch:SetClickParam(achieveDataModel.AchieveType.Trade)
  achieveView.Group_TopRight.Group_Battle.Btn_Switch:SetClickParam(achieveDataModel.AchieveType.Battle)
  achieveView.Group_DownTrade:SetActive(showTrade)
  achieveView.Group_DownBattle:SetActive(showBattle)
  achieveView.Group_TopRight.Group_Trade.Group_On:SetActive(showTrade)
  achieveView.Group_TopRight.Group_Trade.Group_Off:SetActive(not showTrade)
  achieveView.Group_TopRight.Group_Battle.Group_On:SetActive(showBattle)
  achieveView.Group_TopRight.Group_Battle.Group_Off:SetActive(not showBattle)
  if showTrade then
    achieveView.Group_DownTrade.ScrollGrid_TypeList.grid.self:SetDataCount(#achieveDataModel.achieveTradeData)
    achieveView.Group_DownTrade.ScrollGrid_TypeList.grid.self:RefreshAllElement()
    achieveView.Group_TopRight.Group_Battle.Group_Off.Img_Red:SetActive(achieveDataModel.GetRedPointStateByType(achieveDataModel.AchieveType.Battle))
  end
  if showBattle then
    achieveView.Group_DownBattle.StaticGrid_Mission.grid.self:SetDataCount(#achieveDataModel.achieveBattleData)
    achieveView.Group_DownBattle.StaticGrid_Mission.grid.self:RefreshAllElement()
    achieveView.Group_TopRight.Group_Trade.Group_Off.Img_Red:SetActive(achieveDataModel.GetRedPointStateByType(achieveDataModel.AchieveType.Trade))
  end
end

return Controller
