local View = require("UITestLevel/UITestLevelView")
local DataModel = require("UITestLevel/UITestLevelDataModel")
local ViewFunction = require("UITestLevel/UITestLevelViewFunction")
local DataController = require("UITestLevel/UITestLevelDataController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if DataModel.isInitialized == true then
      return
    end
    local params = Json.decode(initParams)
    local isHide = params.isHide
    View.Group_TestLevel.self:SetActive(not isHide)
    View.Group_Statistics.self:SetActive(not isHide)
    DataModel.isHide = isHide
    DataModel.isExpand = true
    DataController.Deserialize()
    DataModel.isInitialized = true
  end,
  awake = function()
  end,
  start = function()
    View.self:SetCanvasOrder(490)
    View.self.IsDisableUIOrder = true
  end,
  update = function()
    if DataModel.maxCost == true then
      DataController.MaxCost()
    end
    if DataModel.refreshCardNoDelay == true then
      DataController.ResetCardsInterverl()
    end
    if DataModel.unlimitedLeaderCondition == true then
      DataController.LeaderCardConditionFinishCheck()
    end
    DataController.CaculateDamageList(DataModel.perFrameDamage)
    DataModel.perFrameDamage = 0
  end,
  ondestroy = function()
    DataController.OnDestroy()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
