local View = require("UIHomeSafe/UIHomeSafeView")
local DataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}
Controller.DifficultyTextId = {
  80601525,
  80601526,
  80601527,
  80601528,
  80601529,
  80601574
}
Controller.DifficultyTextWithColorId = {
  80601782,
  80601783,
  80601784,
  80601785,
  80601786,
  80601787
}
Controller.DifficultyBgPath = {
  "UI/Home/HomeSafe/Difficulty/page_bg_1",
  "UI/Home/HomeSafe/Difficulty/page_bg_2",
  "UI/Home/HomeSafe/Difficulty/page_bg_3",
  "UI/Home/HomeSafe/Difficulty/page_bg_4",
  "UI/Home/HomeSafe/Difficulty/page_bg_5",
  "UI/Home/HomeSafe/Difficulty/page_bg_6"
}
Controller.DifficultyIconPath = {
  "UI/Home/HomeSafe/Difficulty/icon_grade_1",
  "UI/Home/HomeSafe/Difficulty/icon_grade_2",
  "UI/Home/HomeSafe/Difficulty/icon_grade_3",
  "UI/Home/HomeSafe/Difficulty/icon_grade_4",
  "UI/Home/HomeSafe/Difficulty/icon_grade_5",
  "UI/Home/HomeSafe/Difficulty/icon_grade_6"
}
Controller.DifficultyNumPath = {
  "UI/Home/HomeSafe/Difficulty/icon_num_1",
  "UI/Home/HomeSafe/Difficulty/icon_num_2",
  "UI/Home/HomeSafe/Difficulty/icon_num_3",
  "UI/Home/HomeSafe/Difficulty/icon_num_4",
  "UI/Home/HomeSafe/Difficulty/icon_num_5",
  "UI/Home/HomeSafe/Difficulty/icon_num_6"
}
Controller.DifficultyIconBgPath = {
  "UI/Home/HomeSafe/Difficulty/icon_bg_1",
  "UI/Home/HomeSafe/Difficulty/icon_bg_2",
  "UI/Home/HomeSafe/Difficulty/icon_bg_3",
  "UI/Home/HomeSafe/Difficulty/icon_bg_4",
  "UI/Home/HomeSafe/Difficulty/icon_bg_5",
  "UI/Home/HomeSafe/Difficulty/icon_bg_6"
}
Controller.DifficultyBtnImgPath = {
  "UI/Home/HomeSafe/Difficulty/btn_grade_1",
  "UI/Home/HomeSafe/Difficulty/btn_grade_2",
  "UI/Home/HomeSafe/Difficulty/btn_grade_3",
  "UI/Home/HomeSafe/Difficulty/btn_grade_4",
  "UI/Home/HomeSafe/Difficulty/btn_grade_5",
  "UI/Home/HomeSafe/Difficulty/btn_grade_6"
}

function Controller:Init(first)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Level", true)
  Controller:SetNPC()
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  local HomeCommon = require("Common/HomeCommon")
  HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId)
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Zhu.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  local stationId = DataModel.StationId
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local curRepLv = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv or 0
  DataModel.CurStationRepLv = curRepLv
  local buildingCA = PlayerData:GetFactoryData(DataModel.BuildingId, "BuildingFactory")
  if curRepLv < buildingCA.offerPrestige then
    View.Group_Main.Btn_XS.Img_Rep:SetActive(true)
    View.Group_Main.Btn_XS.self:SetBtnInteractable(false)
    View.Group_Main.Btn_XS.Img_Rep.Txt_Rep:SetText(string.format(GetText(80601100), buildingCA.offerPrestige))
  else
    View.Group_Main.Btn_XS.Img_Rep:SetActive(false)
    View.Group_Main.Btn_XS.self:SetBtnInteractable(true)
  end
  View.Group_Main.self:SetActive(true)
  if first then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
    View.Group_Level.self:SetActive(false)
    View.Group_XS.self:SetActive(false)
    View.Group_Report.self:SetActive(false)
  end
  Controller:RefreshRedPoint()
  Controller:RefreshBtnExchange()
  Controller:CheckQuestProcess()
end

function Controller:CheckQuestProcess()
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local t = {}
  t.buildingId = DataModel.BuildingId
  t.isCityMapIn = DataModel.IsCityMapIn
  status.extraUIParamData = t
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      View.Group_Main.Btn_Talk.Txt_:SetText(questCA.name)
    else
    end
  else
    View.Group_Main.Btn_Talk.Txt_:SetText(GetText(80602502))
  end
end

function Controller:RefreshBtnExchange()
  local safeBuildCA = PlayerData:GetFactoryData(DataModel.BuildingId, "BuildingFactory")
  local buildingCA = PlayerData:GetFactoryData(safeBuildCA.exchangeBuildId, "BuildingFactory")
  local isExchangeLock = PlayerData:GetUserInfo().lv < (buildingCA.playerLevel or 0)
  View.Group_Main.Btn_Exchange.Img_Limit.self:SetActive(isExchangeLock)
  if isExchangeLock then
    View.Group_Main.Btn_Exchange.Img_Limit.Group_Limit.Txt_Limit:SetText(string.format(GetText(80601914), buildingCA.playerLevel or 0))
  end
end

function Controller:RefreshPosShow()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Zhu.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
end

function Controller:RefreshResource(showType)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local maxEnergy = PlayerData:GetUserInfo().max_energy or initConfig.energyMax
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Ding")
  View.Group_Ding.Btn_Energy.Txt_Num:SetText(DataModel.GetEnergy() .. "/" .. maxEnergy)
  View.Group_Ding.Group_LevelNum.self:SetActive(showType == 2)
  View.Group_Ding.Group_Tips.self:SetActive(showType == 2)
  View.Group_Ding.Group_ExpelTips.self:SetActive(showType == 1)
  View.Group_Ding.Group_ExpelTips.Txt_Tips:SetText(string.format(GetText(80601532), PlayerData:GetUserInfo().deterrence + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddDeterrence) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddDeterrence, PlayerData:GetUserInfo().deterrence)))
  View.Group_Ding.Btn_YN.self:SetActive(showType == 3)
  if showType == 2 then
    local rewardDataModel = require("UIHomeSafe/UIRewardDataModel")
    View.Group_Ding.Group_LevelNum.Txt_Num:SetText(#rewardDataModel.rewardLevels .. "/" .. rewardDataModel.CurRepInfo.offerAutoRefreshNum)
  elseif showType == 3 then
    View.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  end
end

function Controller:ClickShowLevelPanel()
  Net:SendProto("building.level", function(json)
    PlayerData.ServerData.security_levels = json.special_level.security_levels
    DataModel.InitLevelData(json.special_level.security_levels)
    Controller:ShowLevelPanel()
    Controller:RefreshResource(1)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.levelListText)
    local isPlot = false
    if json.special_level.level_plot then
      local info = json.special_level.level_plot[tostring(DataModel.BuildingId)]
      if info then
        local plotId = tonumber(info.plot_id or 0) or 0
        if 0 < plotId then
          UIManager:Open(UIPath.UIDialog, Json.encode({
            id = plotId,
            plotBuildingId = DataModel.BuildingId
          }), function()
            CommonTips.OpenQuestPcntUpdateTip()
          end, function()
            CommonTips.OpenQuestPcntUpdateTip()
          end)
          isPlot = true
        end
      end
    end
    if not isPlot then
      CommonTips.OpenQuestPcntUpdateTip()
    end
  end, DataModel.BuildingId)
end

function Controller:ShowLevelPanel()
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Ding")
  View.Group_Ding.self:SetActive(true)
  if not View.Group_Level.self.IsActive then
    View.self:PlayAnim("QuestList")
  end
  View.Group_Level.self:SetActive(true)
  View.Group_Level.Group_Tips.self:SetActive(false)
  View.Group_Level.Group_Difficulty.self:SetActive(false)
  if #DataModel.levels > 0 then
    View.Group_Level.Group_Information:SetActive(true)
    View.Group_Level.ScrollGrid_List.self:SetActive(#DataModel.levels > 1)
    if #DataModel.levels > 1 then
      View.Group_Level.ScrollGrid_List.grid.self:SetDataCount(#DataModel.levels)
    end
    Controller:ClickLevelBtn(DataModel.curLevelSelectIdx, true)
  else
    View.Group_Level.Group_Information:SetActive(false)
  end
end

function Controller:ShowRefreshWindow(levelId)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_RefreshWindow")
  if #homeConfig.moneyList > 0 then
    local info = homeConfig.moneyList[1]
    local moneyConfig = PlayerData:GetFactoryData(tonumber(info.id))
    View.Group_RefreshWindow.Img_Item:SetSprite(moneyConfig.iconPath)
    View.Group_RefreshWindow.Txt_Tips:SetText(info.num)
  end
  DataModel.refreshChecked = false
  View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(false)
  View.Group_RefreshWindow.Btn_Confirm.self:SetClickParam(levelId)
  View.Group_RefreshWindow.self:SetActive(true)
end

function Controller:ClickRefresh(checkRefresh, levelId)
  local IsActive = true
  if checkRefresh then
    IsActive = View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local t = {}
  if #homeConfig.moneyList > 0 then
    local info = homeConfig.moneyList[1]
    if PlayerData:GetGoodsById(info.id).num < info.num then
      CommonTips.OpenTips(80600488)
      return
    end
    t[info.id] = info.num
  end
  Net:SendProto("station.security", function(json)
    PlayerData:RefreshUseItems(t)
    Controller:RefreshResource(1)
    View.Group_RefreshWindow.self:SetActive(false)
    if checkRefresh then
      if IsActive == true then
        DataModel.refreshChecked = true
        DataModel.SetRefreshChecked()
      else
        DataModel.refreshChecked = false
      end
    end
    DataModel.InitLevelData(json.special_level.security_levels)
    Controller:ShowLevelPanel()
  end, levelId)
end

function Controller:Update()
  if DataModel.DayRefreshTime > 0 then
    local curTime = TimeUtil:GetServerTimeStamp()
    local isShowReward = View.Group_XS.self ~= nil and View.Group_XS.self.IsActive
    if isShowReward then
      local rewardController = require("UIHomeSafe/UIRewardController")
      rewardController:RefreshEmptyTimeTxt(DataModel.DayRefreshTime - curTime)
    end
    if curTime >= DataModel.DayRefreshTime then
      DataModel.InitDayRefreshTime()
      if View.Group_Level.self.IsActive then
        Controller:ClickShowLevelPanel()
      elseif isShowReward then
        local rewardController = require("UIHomeSafe/UIRewardController")
        rewardController:ClickShowRewardPanel()
      end
    end
  end
end

function Controller:SetNPC()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
end

function Controller:ShowNPCTalk(dialogEnum)
  if dialogEnum == DataModel.NPCDialogEnum.talkText and QuestProcess.CheckTalkDo(DataModel.CacheEventList, View, DataModel.BuildingId, function()
    View.Group_Main:SetActive(true)
  end) then
    View.Group_Main:SetActive(false)
    return
  end
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function Controller:SetSliderViewTargetValue(val)
  DataModel._targetSliderValue = val
end

function Controller:UpdateSliderView()
  if not View.Group_Level.IsActive then
    return
  end
  if not View.Group_Level.Group_Difficulty.IsActive then
    return
  end
  local targetVal = DataModel._targetSliderValue
  if targetVal == nil then
    return
  end
  local sliderView = View.Group_Level.Group_Difficulty.Slider_BG
  local curSliderVal = sliderView.slider.value
  if curSliderVal ~= targetVal then
    local distance = targetVal - curSliderVal
    local valPreFrame = CS.GameSetting.Instance.frameTime * 3
    local isAdd = 0 < distance
    DataModel.isSliderAdd = isAdd
    if valPreFrame >= math.abs(distance) then
      sliderView:SetSliderValue(targetVal)
    elseif isAdd then
      sliderView:SetSliderValue(curSliderVal + valPreFrame)
    elseif not isAdd then
      sliderView:SetSliderValue(curSliderVal - valPreFrame)
    end
  end
end

function Controller:UpdateBgGroupByDifficulty(element, difficulty)
  local index = math.min(difficulty, #Controller.DifficultyBgPath)
  element.Img_BG:SetSprite(Controller.DifficultyBgPath[index])
  element.Img_Icon:SetSprite(Controller.DifficultyIconPath[index])
  element.Img_Num:SetSprite(Controller.DifficultyNumPath[index])
  element.Group_Text.Txt_Difficulty:SetText(GetText(Controller.DifficultyTextId[index]))
end

function Controller:OnSliderViewValChanged(value)
  local progList = DataModel.difficultyProgList
  local difficulty = 1
  for i = 1, #progList - 1 do
    if value > progList[i] and value <= progList[i + 1] then
      difficulty = i
      break
    end
  end
  local centre = (progList[difficulty] + progList[difficulty + 1]) / 2
  local info = DataModel.levels[Controller.curLevelIndex]
  local levelConfig = PlayerData:GetFactoryData(info.levelId, "ListFactory")
  local mutiple
  if value > centre then
    mutiple = difficulty
  else
    mutiple = difficulty - 1
  end
  local groupBottom = View.Group_Level.Group_Difficulty.Group_Di
  groupBottom.Group_Energy.Txt_Energy:SetText(string.format(GetText(80601530), levelConfig.energyEnd + levelConfig.extraEnergy * mutiple))
  groupBottom.Group_Difficulty.Txt_Difficulty:SetText(string.format(GetText(80601531), levelConfig.recomGrade + levelConfig.extraLevelOffset * mutiple))
  local iconBgPath = Controller.DifficultyIconBgPath[mutiple + 1]
  groupBottom.Img_BG:SetSprite(iconBgPath)
  local stepProg = (value - progList[difficulty]) * (#progList - 1)
  local groupBG = View.Group_Level.Group_Difficulty.Group_BG
  local groupBGFade = View.Group_Level.Group_Difficulty.Group_BG_Fade
  groupBG:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1 - stepProg
  groupBGFade:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = stepProg
  local groupSchedule = View.Group_Level.Group_Difficulty.Slider_BG.Group_Schedule
  local staticGridSelect = View.Group_Level.Group_Difficulty.StaticGrid_Select.grid
  for i = 1, difficulty - 1 do
    groupSchedule["Img_Grade_" .. i]:SetAlpha(0)
    local gridSelect = staticGridSelect[i]
    gridSelect.Group_Off.Txt_Difficulty:SetAlpha(1)
    gridSelect.Group_Off.Txt_Num:SetAlpha(1)
    gridSelect.Group_On.Txt_Difficulty:SetAlpha(0)
    gridSelect.Group_On.Txt_Num:SetAlpha(0)
  end
  for i = difficulty + 2, #progList do
    groupSchedule["Img_Grade_" .. i]:SetAlpha(0)
    local gridSelect = staticGridSelect[i]
    gridSelect.Group_Off.Txt_Difficulty:SetAlpha(1)
    gridSelect.Group_Off.Txt_Num:SetAlpha(1)
    gridSelect.Group_On.Txt_Difficulty:SetAlpha(0)
    gridSelect.Group_On.Txt_Num:SetAlpha(0)
  end
  groupSchedule["Img_Grade_" .. difficulty]:SetAlpha(1 - stepProg)
  groupSchedule["Img_Grade_" .. difficulty + 1]:SetAlpha(stepProg)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if not DataModel.isSliderAdd then
    stepProg = 1 - (progList[difficulty + 1] - value) * (#progList - 1) * homeConfig.difficultyTransMutiple
  else
    stepProg = stepProg * homeConfig.difficultyTransMutiple
  end
  local gridNow = staticGridSelect[difficulty]
  gridNow.Group_Off.Txt_Difficulty:SetAlpha(stepProg)
  gridNow.Group_Off.Txt_Num:SetAlpha(stepProg)
  gridNow.Group_On.Txt_Difficulty:SetAlpha(1 - stepProg)
  gridNow.Group_On.Txt_Num:SetAlpha(1 - stepProg)
  local gridNext = staticGridSelect[difficulty + 1]
  gridNext.Group_Off.Txt_Difficulty:SetAlpha(1 - stepProg)
  gridNext.Group_Off.Txt_Num:SetAlpha(1 - stepProg)
  gridNext.Group_On.Txt_Difficulty:SetAlpha(stepProg)
  gridNext.Group_On.Txt_Num:SetAlpha(stepProg)
  if difficulty == DataModel.curSliderIndex then
    return
  end
  DataModel.curSliderIndex = difficulty
  Controller:UpdateBgGroupByDifficulty(groupBG, difficulty)
  Controller:UpdateBgGroupByDifficulty(groupBGFade, difficulty + 1)
end

function Controller:SetDifficulty(index, difficulty)
  local info = DataModel.levels[index]
  PlayerData:SetLevelDifficulty(index, difficulty)
  info.difficulty = difficulty
  Controller:ShowLevelDetail(DataModel.curLevelSelectIdx)
end

function Controller:ClickRewardBox(btn, str)
  local info = DataModel.levels[tonumber(str)]
  local t = {}
  t.buildingId = DataModel.BuildingId
  t.pondId = info.pondId
  UIManager:Open("UI/Home/HomeSafe/ScheduleReward/ScheduleReward", Json.encode(t), function()
    local rewards = PlayerData.ServerData.security_levels[tostring(DataModel.BuildingId)][tostring(info.pondId)].rewards or {}
    local pondCA = PlayerData:GetFactoryData(info.pondId)
    info.canGet = info.canGetCount > 0 and #rewards ~= info.canGetCount
    info.received = #rewards == #pondCA.expelRewardList
    Controller:RefreshRedPoint()
    local element = View.Group_Level.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.curLevelSelectIdx - 1)
    if element then
      element.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. DataModel.BuildingId .. "|" .. info.pondId))
    end
    Controller:ShowLevelDetail(DataModel.curLevelSelectIdx)
    local HomeCommon = require("Common/HomeCommon")
    HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId)
  end)
end

function Controller:ReturnToMain()
  View.Group_Zhu.self:SetActive(false)
  View.Group_Ding.self:SetActive(false)
  View.Group_Level.self:SetActive(false)
  View.Group_XS.self:SetActive(false)
  View.Group_Report.self:SetActive(false)
  Controller:RefreshRedPoint()
  View.Group_Main.self:SetActive(true)
  View.self:PlayAnim("Main")
end

function Controller:RefreshRedPoint()
  View.Group_Main.Btn_Quest.Img_RedPoint:SetActive(RedPointNodeStr.IsHaveRed(RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. DataModel.BuildingId))
end

function Controller:RefreshLevelElement(element, elementIndex)
  local info = DataModel.levels[elementIndex]
  local isSelect = DataModel.curLevelSelectIdx == elementIndex
  element.Img_RedPoint:SetActive(RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. DataModel.BuildingId .. "|" .. info.pondId) > 0)
  element.Group_Off:SetActive(not isSelect)
  element.Group_On:SetActive(isSelect)
  local refreshElement = isSelect and element.Group_On or element.Group_Off
  refreshElement.Txt_Name:SetText(info.levelName)
  if info.seriesType == "Official" then
    refreshElement.Txt_Schedule:SetText(GetText(80602086))
    local expel = info.curExpel / info.maxExpel
    if 1 < expel then
      expel = 1
    end
    refreshElement.Txt_Num:SetText(string.format(GetText(80602089), math.ceil(expel * 100)))
  else
    refreshElement.Txt_Schedule:SetText(GetText(80602085))
    local expel = info.curNum / info.seriesCompleteNum
    if 1 < expel then
      expel = 1
    end
    refreshElement.Txt_Num:SetText(string.format(GetText(80602089), math.ceil(expel * 100)))
  end
  element.Btn_Click:SetClickParam(elementIndex)
end

function Controller:ClickLevelBtn(idx, force)
  if not force and DataModel.curLevelSelectIdx == idx then
    return
  end
  if idx > #DataModel.levels then
    idx = 1
  end
  DataModel.curLevelSelectIdx = idx
  if #DataModel.levels > 1 then
    View.Group_Level.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  Controller:ShowLevelDetail(idx)
end

function Controller:ShowLevelDetail(idx)
  local info = DataModel.levels[idx]
  local element = View.Group_Level.Group_Information
  local levelConfig = PlayerData:GetFactoryData(info.levelId, "LevelFactory")
  local starInt = levelConfig.levelStarInt + 1
  for i = 1, 5 do
    local star = element.Group_Star["Img_Star" .. i]
    star:SetActive(i <= starInt)
  end
  element.Group_Name.Txt_Name:SetText(levelConfig.levelName)
  local isNormal = levelConfig.levelBgType == "Normal"
  element.Img_Icon:SetSprite(isNormal and "UI/Home/HomeSafe/Level/level_icon_normal" or "UI/Home/HomeSafe/Level/level_icon_hua")
  local isLimitRep = DataModel.CurStationRepLv < info.limitRepLv
  local isCustomDifficulty = levelConfig.isCustomDifficulty == true
  local difficulty = info.difficulty
  if isCustomDifficulty then
    element.Group_Difficult.Btn_Difficult.Txt_Difficult:SetText(GetText(Controller.DifficultyTextWithColorId[difficulty]))
  end
  local expel = 0
  if info.seriesType == "Official" then
    element.Group_Schedule.Txt_Name:SetText(string.format(GetText(80602087), info.seriesName))
    expel = info.curExpel / info.maxExpel
    if 1 < expel then
      expel = 1
    end
    element.Group_Wei:SetActive(not isCustomDifficulty)
    element.Group_Difficult:SetActive(isCustomDifficulty)
    element.Group_Test:SetActive(false)
    if isCustomDifficulty then
      element.Group_Difficult.Img_Difficult.Img_Num:SetSprite(Controller.DifficultyNumPath[difficulty])
      element.Group_Difficult.Img_Difficult:SetSprite(Controller.DifficultyBtnImgPath[difficulty])
      element.Group_Difficult.Btn_Difficult:SetClickParam(idx)
    end
    element.Group_Progress.Group_Schedule.Group_Right.Group_Reward:SetActive(true)
    element.Group_Progress.Group_Schedule.Group_Right.Group_Jindu:SetActive(false)
    local box = element.Group_Progress.Group_Schedule.Group_Right.Group_Reward.Group_Box
    local isCanGet = info.canGet
    local received = info.received
    box.Group_Not:SetActive(not isCanGet)
    box.Group_Can:SetActive(isCanGet and not received)
    box.Group_Already:SetActive(received)
    element.Group_Progress.Group_Schedule.Group_Right.Group_Reward.Btn_:SetClickParam(idx)
  else
    element.Group_Schedule.Txt_Name:SetText(GetText(80602085))
    expel = info.curNum / info.seriesCompleteNum
    if 1 < expel then
      expel = 1
    end
    element.Group_Wei:SetActive(false)
    element.Group_Difficult:SetActive(false)
    element.Group_Test:SetActive(true)
    element.Group_Progress.Group_Schedule.Group_Right.Group_Reward:SetActive(false)
    element.Group_Progress.Group_Schedule.Group_Right.Group_Jindu:SetActive(true)
    element.Group_Progress.Group_Schedule.Group_Right.Group_Jindu.Txt_Num:SetText(string.format(GetText(80601235), info.curNum, info.seriesCompleteNum))
  end
  element.Group_Schedule.Txt_Schedule:SetText(string.format(GetText(80602089), math.ceil(expel * 100)))
  element.Group_Progress.Group_Schedule.Img_Di.Img_Progress:SetFilledImgAmount(expel)
  element.Group_Progress.Txt_Dec:SetText(levelConfig.description)
  local dropTableList = levelConfig.dropTableList
  local dropTable = dropTableList[difficulty]
  if dropTable == nil then
    error("关卡id:" .. levelConfig.id .. " 缺少难度" .. difficulty .. "的掉落配置")
  end
  local dropList = PlayerData:GetLevelDropList(levelConfig, difficulty, Clone(info.waves))
  DataModel.dropList = dropList
  element.ScrollGrid_Reward.grid.self:SetDataCount(#dropList)
  element.ScrollGrid_Reward.grid.self:RefreshAllElement()
  element.ScrollGrid_Reward.grid.self:MoveToTop()
  element.Img_Limit:SetActive(isLimitRep)
  element.Group_Battle:SetActive(not isLimitRep)
  if isLimitRep then
    element.Img_Limit.Txt_Rep:SetText(string.format(GetText(80601015), info.limitRepLv))
  else
    element.Group_Battle.Btn_Battle.self:SetClickParam(idx)
    element.Group_Battle.Btn_Battle.Img_Cost.Txt_Cost:SetText(levelConfig.energyEnd + levelConfig.extraEnergy * (difficulty - 1))
    local level = PlayerData:GetUserInfo().lv
    if not levelConfig.isEnemyLvEquilsPlayer then
      level = levelConfig.recomGrade + levelConfig.extraLevelOffset * (difficulty - 1)
    end
    element.Group_Battle.Img_Recommend.Txt_Grade:SetText(level)
  end
  local buildingCA = PlayerData:GetFactoryData(DataModel.BuildingId)
  element.Img_Di:SetSprite(buildingCA.expelBgPath)
end

function Controller:RefreshReward(element, elementIndex)
  local dropList = DataModel.dropList
  local dropInfo = dropList[elementIndex]
  local BtnItem = require("Common/BtnItem")
  BtnItem:SetItem(element.Group_Item, {
    id = dropInfo.id,
    num = ""
  })
  element.Group_Item.Btn_Item:SetClickParam(dropInfo.id)
end

function Controller:ClickBattle(str)
  local info = DataModel.levels[tonumber(str)]
  local levelId = info.levelId
  local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  local detailDo = function()
    if CommonTips.OpenBuyEnergyTips(levelId, function()
      Controller:RefreshResource(1)
    end, nil, nil, info.difficulty) then
      return
    end
    local enemyWaveStr = ""
    if info.waves ~= nil then
      for i = 1, #info.waves do
        if 3 < i then
          break
        end
        if enemyWaveStr ~= "" then
          enemyWaveStr = enemyWaveStr .. ","
        end
        enemyWaveStr = enemyWaveStr .. info.waves[i].enemyWaveId
      end
    end
    local status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false,
      difficulty = info.difficulty,
      enemy_ids = enemyWaveStr
    }
    local t = {}
    t.buildingId = DataModel.BuildingId
    t.isCityMapIn = DataModel.IsCityMapIn
    t.autoShowLevel = 1
    status.extraUIParamData = t
    PlayerData.BattleInfo.battleStageId = levelId
    PlayerData.BattleCallBackPage = "UI/Home/HomeSafe/HomeSafe"
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end
  if not levelCA.isEnemyLvEquilsPlayer and levelCA.recomGrade + levelCA.extraLevelOffset * (info.difficulty - 1) - PlayerData:GetPlayerLevel() >= 5 then
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "HomeSafeLevelHardTip"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    CommonTips.OnPrompt(80601227, nil, nil, detailDo, nil, nil, nil, nil, checkTipParam)
  else
    detailDo()
  end
end

function Controller:OpenExchangeBuild()
  local safeBuildCA = PlayerData:GetFactoryData(DataModel.BuildingId, "BuildingFactory")
  local buildingCA = PlayerData:GetFactoryData(safeBuildCA.exchangeBuildId, "BuildingFactory")
  if PlayerData:GetUserInfo().lv < (buildingCA.playerLevel or 0) then
    return
  end
  local storeList = buildingCA.exchangeStoreList
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
  Net:SendProto("shop.info", function(json)
    UIManager:Open(buildingCA.uiPath, Json.encode({
      buildingId = safeBuildCA.exchangeBuildId,
      isCityMapIn = false,
      name = buildingCA.name,
      stationId = DataModel.StationId,
      bgPath = DataModel.BgPath,
      npcId = DataModel.NpcId,
      initMode = "Exchange"
    }))
    PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
  end, storeId)
end

return Controller
