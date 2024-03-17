local View = require("UIAdvMain/UIAdvMainView")
local DataModel = require("UIAdvMain/UIAdvMainDataModel")
local ViewFunction = require("UIAdvMain/UIAdvMainViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
  end,
  awake = function()
  end,
  start = function()
    if LoadingManager.isLoading then
      LoadingManager:SetLoadingPercent(1)
    end
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
