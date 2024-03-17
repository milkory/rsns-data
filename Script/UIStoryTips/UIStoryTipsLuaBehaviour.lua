local View = require("UIStoryTips/UIStoryTipsView")
local DataModel = require("UIStoryTips/UIStoryTipsDataModel")
local ViewFunction = require("UIStoryTips/UIStoryTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    View.Txt_Tips:SetText(GetText(info.textId))
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
