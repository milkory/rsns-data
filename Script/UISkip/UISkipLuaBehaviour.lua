local View = require("UISkip/UISkipView")
local DataModel = require("UISkip/UISkipDataModel")
local ViewFunction = require("UISkip/UISkipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.data = data
    DataModel.Cards = data.cards
    DataModel.Type = data.type
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
