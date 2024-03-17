local DataModel = require("UIChapterSelect/UIAssessment/UIAssessmentDataModel")
local View = require("UIChapterSelect/UIChapterSelectView")
local AllUnlockLevelCleared = function()
  local chapterLevel = PlayerData.ServerData.chapter_level
  for k, v in pairs(DataModel.levelList) do
    if chapterLevel[v] == nil then
      return false
    end
  end
  return true
end
local module = {}

function module:RefreshAll()
  self.RefreshGrid(View.Group_Assessment.Group_Top.ScrollGrid_First.grid, table.count(DataModel.chapterList))
  self.RefreshGrid(View.Group_Assessment.Group_Left.ScrollGrid_Second.grid, table.count(DataModel.levelList))
end

function module.RefreshGrid(gridList, count)
  gridList.self:SetDataCount(count)
  gridList.self:RefreshAllElement()
end

function module.SetChapterElement(element, elementIndex)
  local chapterList = DataModel.chapterList
  local dataInfo = PlayerData:GetFactoryData(chapterList[elementIndex].chapterId, "ChapterFactory")
  element.Btn_Inspection.Txt_Inspection:SetText(dataInfo.nameCN)
  element.Btn_Inspection.Img_oh:SetActive(AllUnlockLevelCleared())
  element.Btn_Inspection.Img_mask:SetActive(elementIndex == DataModel.selectedChapterIndex)
end

function module.SetLevelElement(element, elementIndex)
  local dataInfo = PlayerData:GetFactoryData(DataModel.levelList[elementIndex].levelId, "LevelFactory")
  element.Btn_Inspection.Img_mask:SetActive(false)
  element.Btn_Inspection.Txt_Inspection:SetText(dataInfo.levelChapter)
  element.Btn_Inspection.Img_mask.Txt_Inspection:SetText(dataInfo.levelChapter)
  element.Btn_Inspection.Img_mask:SetActive(elementIndex == DataModel.selectedLevelIndex)
end

return module
