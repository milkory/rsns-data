local View = require("UILifeSkill/UILifeSkillView")
local DataModel = require("UILifeSkill/UILifeSkillDataModel")
local Controller = require("UILifeSkill/UILifeSkillController")
local ViewFunction = require("UILifeSkill/UILifeSkillViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.HomeSkillInfo = nil
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
