local View = require("UIGroup_InputNote/UIGroup_InputNoteView")
local DataModel = require("UIGroup_InputNote/UIGroup_InputNoteDataModel")
local ViewFunction = require("UIGroup_InputNote/UIGroup_InputNoteViewFunction")
local Controller = require("UIGroup_InputNote/UIGroup_InputNoteController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:InitView()
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
