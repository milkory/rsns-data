local View = require("UIChapter/UIChapterView")
local ViewFunction = require("UIChapter/UIChapterViewFunction")
local DataModel = require("UIChapter/UIChapterDataModel")
local UIContoller = require("UIChapter/Model_UIController")
local chapterInitParams
local deserialized = false
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_DropDetails.self:SetActive(false)
    View.Group_LeftBottom.self:SetActive(false)
    View.Group_LevelChainInfo.self:SetActive(false)
    View.Group_ChooseSkill.self:SetActive(false)
    View.Group_LCSettlement.self:SetActive(false)
    View.Group_LevelChainSquad.self:SetActive(false)
    chapterInitParams = initParams
    if chapterInitParams ~= nil and chapterInitParams ~= "" then
      DataModel.ChapterRecoure = Json.decode(chapterInitParams)
      if DataModel.ChapterRecoure.GobackUIPath ~= nil then
        DataModel.GobackUIPath = DataModel.ChapterRecoure.GobackUIPath
      end
      UIContoller:Refresh(DataModel.ChapterRecoure.selectedLevelId, false)
    end
    View.self:PlayAnim("ChapterIn")
    deserialized = true
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    deserialized = false
    DataModel.dropList = {}
    DataModel.firstPassAward = {}
    DataModel.enemyDetailShowInfo = {}
    DataModel.curShowIdx = 0
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
