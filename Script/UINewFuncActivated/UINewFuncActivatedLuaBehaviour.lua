local View = require("UINewFuncActivated/UINewFuncActivatedView")
local DataModel = require("UINewFuncActivated/UINewFuncActivatedDataModel")
local Controller = require("UINewFuncActivated/UINewFuncActivatedController")
local ViewFunction = require("UINewFuncActivated/UINewFuncActivatedViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.ShowInfo = Json.decode(initParams)
    Controller:ShowUnlock()
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
