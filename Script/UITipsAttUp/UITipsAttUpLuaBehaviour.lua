local View = require("UITipsAttUp/UITipsAttUpView")
local DataModel = require("UITipsAttUp/UITipsAttUpDataModel")
local ViewFunction = require("UITipsAttUp/UITipsAttUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local list = Json.decode(initParams)
    DataModel.RoleAttributeCurrent = list.current
    DataModel.RoleAttributeNext = list.next
    View.Group_Show.Group_TAMiddle.StaticGrid_Item.grid.self:RefreshAllElement()
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
