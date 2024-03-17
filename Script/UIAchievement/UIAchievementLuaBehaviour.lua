local View = require("UIAchievement/UIAchievementView")
local DataModel = require("UIAchievement/UIAchievementDataModel")
local ViewFunction = require("UIAchievement/UIAchievementViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    ViewFunction.RefreshAchieveList(1)
  end,
  awake = function()
    DataModel:_init()
    DataModel.pointItemBarWidth = View.Group_AchievePoint.ScrollGrid_AchievePoint.grid[1].Group_JinDu.Img_Di.Rect.sizeDelta.x
    DataModel.questItemBarWidth = View.Group_AchieveQuest.ScrollGrid_Level.grid[1].Group_JinDu.Img_Di.Rect.sizeDelta.x
    DataModel.stageBarWidth = View.Group_JieDuan.Group_JinDu.Img_.Rect.sizeDelta.x
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    for i, v in ipairs(DataModel.achieveGroupList) do
      local redName = "AchieveGroup" .. i
      RedpointTree:SetCallBack(RedpointTree.NodeNames[redName], redName, nil)
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
