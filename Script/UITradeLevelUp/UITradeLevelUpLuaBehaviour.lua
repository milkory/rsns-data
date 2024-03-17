local View = require("UITradeLevelUp/UITradeLevelUpView")
local DataModel = require("UITradeLevelUp/UITradeLevelUpDataModel")
local ViewFunction = require("UITradeLevelUp/UITradeLevelUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    View.Txt_LevelPre:SetText(info.preLevel)
    View.Txt_Level:SetText(info.level)
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
