local View = require("UIChapterSelect/UIChapterSelectView")
local ViewFunction = require("UIChapterSelect/UIChapterSelectViewFunction")
local GridController = require("UIChapterSelect/Controller_Grid")
local DataModel = require("UIChapterSelect/UIChapterSelectDataModel")
local DataController = require("UIChapterSelect/UIChapterSelectDataController")
local Luabehaviour = {
  serialize = function()
    local status = {}
    status.DataModel = DataController:Serialize()
    return Json.encode(status)
  end,
  deserialize = function(initParams)
    DataModel.IsDrag = false
    DataModel.IsFirst = true
    DataModel.IsJump = false
    SoundManager:PauseBGM(true)
    local idx = PlayerData:GetPlayerPrefs("int", "ChapterIndex")
    if idx < 1 then
      idx = 1
    end
    if initParams == nil then
      DataModel.selectedIndex = idx
    else
      local status = Json.decode(initParams)
      if status.UI and status.UI == "BattlePass" then
        DataModel.Jump = status
        DataModel.IsJump = true
        DataModel.selectedIndex = idx
      else
        DataModel.selectedIndex = status.DataModel.selectedIndex
      end
    end
    PlayerData.selectedRightIndex = PlayerData.selectedRightIndex or 1
    View.self:PlayAnim("In")
    if PlayerData.ChooseChapterType == 2 then
      DataModel.OldIndex = 2
    else
      DataModel.OldIndex = 1
    end
    PlayerData.Last_Chapter_Parms = {}
    DataModel.ChangeOpenChapter(true)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  onenable = function()
  end,
  ondestroy = function()
    DataController:OnDestroy()
    SoundManager:PauseBGM(false)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
