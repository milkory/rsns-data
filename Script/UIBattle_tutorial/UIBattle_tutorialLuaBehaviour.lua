local View = require("UIBattle_tutorial/UIBattle_tutorialView")
local DataModel = require("UIBattle_tutorial/UIBattle_tutorialDataModel")
local ViewFunction = require("UIBattle_tutorial/UIBattle_tutorialViewFunction")
local Controller = require("UIBattle_tutorial/UIBattle_Controller")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller.InitUI(initParams)
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
