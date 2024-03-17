local View = require("UINotice_beforeLogin/UINotice_beforeLoginView")
local DataModel = require("UINotice_beforeLogin/UINotice_beforeLoginDataModel")
local ViewFunction = require("UINotice_beforeLogin/UINotice_beforeLoginViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.count = Json.decode(initParams)
    DataModel.Init(DataModel.count)
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
