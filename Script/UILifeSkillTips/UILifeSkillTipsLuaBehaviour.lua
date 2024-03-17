local View = require("UILifeSkillTips/UILifeSkillTipsView")
local DataModel = require("UILifeSkillTips/UILifeSkillTipsDataModel")
local ViewFunction = require("UILifeSkillTips/UILifeSkillTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local role_id = tonumber(initParams)
    DataModel.init(role_id)
    View.Group_skillFrame.StaticGrid_.grid.self:RefreshAllElement()
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
