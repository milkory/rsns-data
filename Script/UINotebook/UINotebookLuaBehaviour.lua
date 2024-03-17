local View = require("UINotebook/UINotebookView")
local DataModel = require("UINotebook/UINotebookDataModel")
local ViewFunction = require("UINotebook/UINotebookViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.SetJsonData(initParams)
    end
    DataModel.InitData()
    DataModel.RefreshOnSHow()
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
    DOTweenTools.KillAll()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
