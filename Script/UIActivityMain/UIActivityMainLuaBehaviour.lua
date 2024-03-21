local View = require("UIActivityMain/UIActivityMainView")
local DataModel = require("UIActivityMain/UIActivityMainDataModel")
local Controller = require("UIActivityMain/UIActivityMainController")
local ViewFunction = require("UIActivityMain/UIActivityMainViewFunction")
local Luabehaviour = {
  serialize = function()
    local parms = {}
    parms.index = DataModel.ChooseLeftIndex
    return Json.encode(parms)
  end,
  deserialize = function(initParams)
    local index
    if initParams then
      index = Json.decode(initParams).index
    end
    Controller:Init(index)
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
