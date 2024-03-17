local View = require("UIExchangeTips/UIExchangeTipsView")
local DataModel = require("UIExchangeTips/UIExchangeTipsDataModel")
local ViewFunction = require("UIExchangeTips/UIExchangeTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel:Init(param)
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
