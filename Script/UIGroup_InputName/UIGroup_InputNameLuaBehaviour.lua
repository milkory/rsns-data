local View = require("UIGroup_InputName/UIGroup_InputNameView")
local DataModel = require("UIGroup_InputName/UIGroup_InputNameDataModel")
local ViewFunction = require("UIGroup_InputName/UIGroup_InputNameViewFunction")
local Controller = require("UIGroup_InputName/UIGroup_InputNameController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = {}
    if initParams ~= nil and initParams ~= "" then
      data = Json.decode(initParams)
    end
    Controller:InitView(data)
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
