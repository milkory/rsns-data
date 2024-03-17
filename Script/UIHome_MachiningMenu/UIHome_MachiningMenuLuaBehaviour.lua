local View = require("UIHome_MachiningMenu/UIHome_MachiningMenuView")
local DataModel = require("UIHome_MachiningMenu/UIHome_MachiningMenuDataModel")
local ViewFunction = require("UIHome_MachiningMenu/UIHome_MachiningMenuViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.SetJsonData(initParams)
    end
    DataModel.InitData()
    DataModel.RefreshOnShow()
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
