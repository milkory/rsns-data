local View = require("UIConvertTips/UIConvertTipsView")
local DataModel = require("UIConvertTips/UIConvertTipsDataModel")
local ViewFunction = require("UIConvertTips/UIConvertTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil and initParams ~= "" then
      DataModel:OpenBuyTips(true, Json.decode(initParams))
    end
  end,
  awake = function()
  end,
  start = function()
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
