local View = require("UIHomeSafe/UIHomeSafeView")
local DataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local RewardDataModel = require("UIHomeSafe/UIRewardDataModel")
local Controller = require("UIHomeSafe/UIHomeSafeController")
local RewardController = require("UIHomeSafe/UIRewardController")
local RouteLevelController = require("UIHomeSafe/UIRouteLevelController")
local BtnItem = require("Common/BtnItem")
local ViewFunction = {
  HomeSafe_Group_Main_Btn_Quest_Click = function(btn, str)
    Controller:ClickShowLevelPanel()
  end,
  HomeSafe_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeSafe_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Level.self.IsActive or View.Group_XS.self.IsActive or View.Group_Report.self.IsActive then
      Controller:ReturnToMain()
      return
    end
    if DataModel.IsCityMapIn then
      UIManager:Open("UI/CityMap/CityMap", Json.encode({
        stationId = DataModel.StationId
      }))
    else
      UIManager:GoBack()
    end
  end,
  HomeSafe_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeSafe_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303384}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeSafe_Group_Main_Btn_XS_Click = function(btn, str)
    RewardController:ClickShowRewardPanel()
  end,
  HomeSafe_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeSafe_Group_Zhu_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local HomeCommon = require("Common/HomeCommon")
    HomeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId)
    end)
  end,
  HomeSafe_Group_Main_Btn_Report_Click = function(btn, str)
    RouteLevelController.OpenReportPanel()
  end,
  HomeSafe_Group_Main_Btn_Exchange_Click = function(btn, str)
    Controller:OpenExchangeBuild()
  end,
  HomeSafe_Group_RefreshWindow_Btn_Close_Click = function(btn, str)
    DataModel.refreshChecked = false
    View.Group_RefreshWindow.self:SetActive(false)
  end,
  HomeSafe_Group_RefreshWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    DataModel.refreshChecked = not DataModel.refreshChecked
    View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(DataModel.refreshChecked)
  end,
  HomeSafe_Group_RefreshWindow_Btn_Confirm_Click = function(btn, str)
    local levelId = tonumber(str)
    Controller:ClickRefresh(true, levelId)
  end,
  HomeSafe_Group_RefreshWindow_Btn_Cancel_Click = function(btn, str)
    DataModel.refreshChecked = false
    View.Group_RefreshWindow.self:SetActive(false)
  end,
  HomeSafe_Group_Ding_Btn_Energy_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      Controller:RefreshResource(1)
    end)
  end,
  HomeSafe_Group_Ding_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  HomeSafe_Group_XS_Group_Information_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local itemInfo = RewardDataModel.CurShowDrop[elementIndex]
    local BtnItem = require("Common/BtnItem")
    BtnItem:SetItem(element.Group_Item, {
      id = itemInfo.id,
      num = ""
    })
    element.Group_Item.Btn_Item:SetClickParam(itemInfo.id)
  end,
  HomeSafe_Group_XS_Group_Information_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  HomeSafe_Group_XS_Group_Information_Group_TZ_Btn_QW_Click = function(btn, str)
    local levelId = tonumber(str)
    local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
    local detailDo = function()
      local res = CommonTips.OpenBuyEnergyTips(levelId, function()
        Controller:RefreshResource(1)
      end)
      if res then
        return
      end
      local status = {
        Current = "Chapter",
        squadIndex = PlayerData.BattleInfo.squadIndex,
        hasOpenThreeView = false
      }
      local t = {}
      t.buildingId = DataModel.BuildingId
      t.isCityMapIn = DataModel.IsCityMapIn
      t.autoShowLevel = 2
      status.extraUIParamData = t
      PlayerData.BattleInfo.battleStageId = levelId
      PlayerData.BattleCallBackPage = "UI/Home/HomeSafe/HomeSafe"
      UIManager:Open("UI/Squads/Squads", Json.encode(status))
    end
    if not levelCA.isEnemyLvEquilsPlayer and levelCA.recomGrade - PlayerData:GetPlayerLevel() >= 5 then
      local checkTipParam = {}
      checkTipParam.isCheckTip = true
      checkTipParam.checkTipKey = "HomeSafeLevelHardTip"
      checkTipParam.checkTipType = 1
      checkTipParam.showDanger = true
      CommonTips.OnPrompt(80601227, nil, nil, detailDo, nil, nil, nil, nil, checkTipParam)
    else
      detailDo()
    end
  end,
  HomeSafe_Group_XS_Group_Right_ScrollGrid_Right_SetGrid = function(element, elementIndex)
    RewardController:RefreshRightElement(element, elementIndex)
  end,
  HomeSafe_Group_XS_Group_Right_ScrollGrid_Right_Group_Item_Group_Level_Btn__Click = function(btn, str)
    RewardController:SelectIdx(tonumber(str))
  end,
  HomeSafe_Group_XS_Group_Right_ScrollGrid_Right_Group_Item_Group_Add_Btn__Click = function(btn, str)
    RewardController:AddRewardLevel()
  end,
  HomeSafe_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  HomeSafe_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  HomeSafe_Group_Report_Group_Tab_Group_Personal_Btn__Click = function(btn, str)
    RouteLevelController.ShowPersonalInfo()
  end,
  HomeSafe_Group_Report_Group_Tab_Group_Online_Btn__Click = function(btn, str)
    RouteLevelController.ShowOnlineInfo()
  end,
  HomeSafe_Group_Report_Group_Tab_Group_Record_Btn__Click = function(btn, str)
    RouteLevelController.ShowCompleteInfo()
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelInfo(element, elementIndex, 1)
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_Group_Item_Group_Not_Btn_Appear_Click = function(btn, str)
    RouteLevelController.Share2Online(str)
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_Group_Item_Group_Not_Group_TZ_Btn_QW_Click = function(btn, str)
    RouteLevelController.StartBattle(tonumber(str))
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_Group_Item_Group_Allredy_Btn_Appear_Click = function(btn, str)
    RouteLevelController.CancelShare(str)
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelRewardInfo(element, elementIndex, tonumber(element.ParentParam), 1)
  end,
  HomeSafe_Group_Report_Group_PersonalList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    RouteLevelController.ShowRewardInfoPanel(str)
  end,
  HomeSafe_Group_Report_Group_OnlineList_ScrollGrid_List_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelInfo(element, elementIndex, 2)
  end,
  HomeSafe_Group_Report_Group_OnlineList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelRewardInfo(element, elementIndex, tonumber(element.ParentParam), 2)
  end,
  HomeSafe_Group_Report_Group_OnlineList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    RouteLevelController.ShowRewardInfoPanel(str)
  end,
  HomeSafe_Group_Report_Group_OnlineList_ScrollGrid_List_Group_Item_Group_TZ_Btn_QW_Click = function(btn, str)
    RouteLevelController.StartOnlineBattle(tonumber(str))
  end,
  HomeSafe_Group_Report_Group_OnlineList_Group_Bottom_Group_Refresh_Btn__Click = function(btn, str)
    RouteLevelController.RefreshOnlineInfo()
  end,
  HomeSafe_Group_Report_Group_LogList_ScrollGrid_List_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelInfo(element, elementIndex, 3)
  end,
  HomeSafe_Group_Report_Group_LogList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    RouteLevelController.ShowLevelRewardInfo(element, elementIndex, tonumber(element.ParentParam), 3)
  end,
  HomeSafe_Group_Report_Group_LogList_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    RouteLevelController.ShowRewardInfoPanel(str)
  end,
  HomeSafe_Group_Report_Group_LogList_ScrollGrid_List_Group_Item_Group_LIkeBtn_Btn__Click = function(btn, str)
    local Group_add = btn.transform.parent.parent.transform:Find("Group_Add"):GetComponent(typeof(CS.Seven.UIGroup))
    RouteLevelController.AddLikeNum(Group_add, tonumber(str))
  end,
  HomeSafe_Group_Report_Group_LogList_ScrollGrid_List_Group_Item_Group_GetBack_Btn__Click = function(btn, str)
    RouteLevelController.RecvRewards(tonumber(str))
  end,
  HomeSafe_Group_Ding_Group_Tips_Btn_Tips_Click = function(btn, str)
    View.Group_XS.Group_Tips.self:SetActive(true)
  end,
  HomeSafe_Group_Ding_Group_ExpelTips_Btn__Click = function(btn, str)
    View.Group_Level.Group_Tips.self:SetActive(true)
  end,
  HomeSafe_Group_Level_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Level.Group_Tips.self:SetActive(false)
  end,
  HomeSafe_Group_XS_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_XS.Group_Tips.self:SetActive(false)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Btn_Affirm_Click = function(btn, str)
    View.Group_Level.Group_Difficulty.self:SetActive(false)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_Difficulty_Slider = function(slider, value)
    Controller:SetSliderViewTargetValue(value)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_Difficulty_SliderDown = function(slider)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_Difficulty_SliderUp = function(slider)
    local value = slider.slider.value
    local progList = DataModel.difficultyProgList
    local difficulty = 1
    for i = 1, #progList - 1 do
      if value > progList[i] and value <= progList[i + 1] then
        if value >= (progList[i + 1] + progList[i]) / 2 then
          difficulty = i + 1
        else
          difficulty = i
        end
        value = progList[difficulty]
        break
      end
    end
    Controller:SetDifficulty(Controller.curLevelIndex, difficulty)
    slider.slider.value = value
  end,
  HomeSafe_Group_Level_Group_Difficulty_Group_Item_Btn__Click = function(btn, str)
  end,
  HomeSafe_Group_Level_Group_Difficulty_StaticGrid_Select_SetGrid = function(element, elementIndex)
    local levelIndex = Controller.curLevelIndex
    local info = DataModel.levels[levelIndex]
    local difficulty = info.difficulty
    if elementIndex == difficulty then
      element.Group_On.Txt_Difficulty:SetAlpha(1)
      element.Group_On.Txt_Num:SetAlpha(1)
      element.Group_Off.Txt_Difficulty:SetAlpha(0)
      element.Group_Off.Txt_Num:SetAlpha(0)
    else
      element.Group_On.Txt_Difficulty:SetAlpha(0)
      element.Group_On.Txt_Num:SetAlpha(0)
      element.Group_Off.Txt_Difficulty:SetAlpha(1)
      element.Group_Off.Txt_Num:SetAlpha(1)
    end
    local difficultyText = GetText(Controller.DifficultyTextId[elementIndex])
    local numText = string.format(GetText(80601584), math.floor(DataModel.difficultyProgList[elementIndex] * 100))
    element.Group_On.Txt_Difficulty:SetText(difficultyText)
    element.Group_On.Txt_Num:SetText(numText)
    element.Group_Off.Txt_Difficulty:SetText(difficultyText)
    element.Group_Off.Txt_Num:SetText(numText)
    element.Btn_:SetClickParam(elementIndex)
  end,
  HomeSafe_Group_Level_Group_Difficulty_StaticGrid_Select_Group_Item_Btn__Click = function(btn, str)
    Controller:SetDifficulty(Controller.curLevelIndex, tonumber(str))
    View.Group_Level.Group_Difficulty.Slider_Difficulty:SetSliderValue(DataModel.difficultyProgList[tonumber(str)])
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_BG_Slider = function(slider, value)
    Controller:OnSliderViewValChanged(value)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_BG_SliderDown = function(slider)
  end,
  HomeSafe_Group_Level_Group_Difficulty_Slider_BG_SliderUp = function(slider)
  end,
  HomeSafe_Group_Level_Group_Information_Group_Difficult_Btn_Difficult_Click = function(btn, str)
    local index = tonumber(str)
    Controller.curLevelIndex = index
    View.Group_Level.Group_Difficulty.self:SetActive(true)
    local info = DataModel.levels[index]
    local levelConfig = PlayerData:GetFactoryData(info.levelId, "LevelFactory")
    local dropTableList = levelConfig.dropTableList
    DataModel.difficultyProgList = {}
    for i = 1, #dropTableList do
      DataModel.difficultyProgList[i] = (i - 1) / (#dropTableList - 1)
    end
    View.Group_Level.Group_Difficulty.StaticGrid_Select.grid.self:SetDataCount(#dropTableList)
    View.Group_Level.Group_Difficulty.StaticGrid_Select.grid.self:RefreshAllElement()
    View.Group_Level.Group_Difficulty.Slider_Difficulty:SetSliderValue(DataModel.difficultyProgList[info.difficulty])
    View.Group_Level.Group_Difficulty.Slider_BG:SetSliderValue(DataModel.difficultyProgList[info.difficulty])
    DataModel.curSliderIndex = nil
    Controller:OnSliderViewValChanged(DataModel.difficultyProgList[info.difficulty])
  end,
  HomeSafe_Group_Level_Group_Information_Group_Progress_Group_Schedule_Group_Right_Group_Reward_Btn__Click = function(btn, str)
    Controller:ClickRewardBox(btn, str)
  end,
  HomeSafe_Group_Level_Group_Information_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshReward(element, elementIndex)
  end,
  HomeSafe_Group_Level_Group_Information_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  HomeSafe_Group_Level_Group_Information_Group_Battle_Btn_Battle_Click = function(btn, str)
    Controller:ClickBattle(str)
  end,
  HomeSafe_Group_Level_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:RefreshLevelElement(element, elementIndex)
  end,
  HomeSafe_Group_Level_ScrollGrid_List_Group_Item_Btn_Click_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickLevelBtn(idx)
  end
}
return ViewFunction
