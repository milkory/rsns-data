local View = require("UIBuyTips/UIBuyTipsView")
local DataModel = require("UIBuyTips/UIBuyTipsDataModel")
local ViewFunction = require("UIBuyTips/UIBuyTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil and initParams ~= "" then
      DataModel.currentNum = 0
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
