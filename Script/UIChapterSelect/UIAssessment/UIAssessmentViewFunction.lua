local View = require("UIChapterSelect/UIChapterSelectView")
local DataModel = require("UIChapterSelect/UIAssessment/UIAssessmentDataModel")
local GridController = require("UIChapterSelect/UIAssessment/UIAssessmentGridController")
local UIController = require("UIChapterSelect/UIAssessment/UIAssessmentUIController")
local DataController = require("UIChapterSelect/UIAssessment/UIAssessmentDataController")
local ViewFunction = {
  Assessment_Group_Middle_ScrollGrid_Second_SetGrid = function(element, elementIndex)
    element.Btn_Inspection.self:SetClickParam(elementIndex)
    GridController.SetLevelElement(element, elementIndex)
  end,
  Assessment_Group_Middle_ScrollGrid_Second_Group_Item_Btn_Inspection_Click = function(btn, str)
    local index = tonumber(str)
    if DataModel.selectedLevelIndex == index then
      return
    end
    DataModel.selectedLevelIndex = index
    local levelCA = PlayerData:GetFactoryData(DataModel.levelList[DataModel.selectedLevelIndex].levelId, "LevelFactory")
    GridController.RefreshGrid(View.Group_Assessment.Group_Left.ScrollGrid_Second.grid, #DataModel.levelList)
    UIController.RrefreshLevelInfo(View.Group_Assessment.Group_Right, levelCA)
    UIController.RefreshBonus(View.Group_Bonus, View.Group_Assessment, levelCA)
  end,
  Assessment_Group_Right_Group_Type_Btn_Type_Click = function(btn, str)
  end,
  Assessment_Group_Right_Btn_Start_Click = function(btn, str)
    local levelId = DataModel.levelList[DataModel.selectedLevelIndex].levelId
    PlayerData.ChooseChapterType = 3
    PlayerData.BattleCallBackPage = "UI/ChapterSelect/ChapterSelect"
    PlayerData.Last_Chapter_Parms = nil
    local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
    UIController.StartBattle(levelCA)
  end,
  Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_00_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(View.Group_Bonus.Img_win.Group_Item_01.Current.id)
  end,
  Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_01_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(View.Group_Bonus.Img_win.Group_Item_02.Current.id)
  end,
  Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_02_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(View.Group_Bonus.Img_win.Group_Item_03.Current.id)
  end,
  Assessment_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Assessment_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Assessment_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Assessment_Group_Left_ScrollGrid_First_SetGrid = function(element, elementIndex)
    element.Btn_Inspection.self:SetClickParam(elementIndex)
    GridController.SetChapterElement(element, elementIndex)
  end,
  Assessment_Group_Left_ScrollGrid_First_Group_Item_Btn_Inspection_Click = function(btn, str)
    local index = tonumber(str)
    if DataModel.selectedChapterIndex == index then
      return
    end
    DataModel.selectedChapterIndex = index
    local selectedChapterId = PlayerData:GetFactoryData(99900001, "ConfigFactory").collegeChapter[index].chapterId
    DataModel.levelList = DataController.GetUnlockedLevels(selectedChapterId)
    DataModel.selectedLevelIndex = DataController.FindLastClearedLevelOrDefault(DataModel.levelList)
    GridController:RefreshAll()
    UIController:RefreshAll()
  end,
  Assessment_Group_Right_Group_Pre_ScrollGrid_Lunbo_SetGrid = function(element, elementIndex)
  end,
  Assessment_Group_Right_Group_Bonus_Btn_Bonus_Click = function(btn, str)
    UIController.BonusClick()
  end,
  Assessment_Group_Bonus_Btn_BMask_Click = function(btn, str)
    UIController:RefreshAll()
    View.Group_Bonus.self:SetActive(false)
  end
}
return ViewFunction
