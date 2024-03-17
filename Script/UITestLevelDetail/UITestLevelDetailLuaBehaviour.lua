local View = require("UITestLevelDetail/UITestLevelDetailView")
local DataModel = require("UITestLevelDetail/UITestLevelDetailDataModel")
local ViewFunction = require("UITestLevelDetail/UITestLevelDetailViewFunction")
local Controller = require("UITestLevelDetail/UITestLevelDetailController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    Controller.InitView(data)
  end,
  awake = function()
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
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
