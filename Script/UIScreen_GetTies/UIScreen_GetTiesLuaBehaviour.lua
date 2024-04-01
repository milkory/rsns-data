local View = require("UIScreen_GetTies/UIScreen_GetTiesView")
local DataModel = require("UIScreen_GetTies/UIScreen_GetTiesDataModel")
local ViewFunction = require("UIScreen_GetTies/UIScreen_GetTiesViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.Init(data)
    View.ScrollGrid_GetTies.grid.self:SetDataCount(#DataModel.NewBuffList)
    View.ScrollGrid_GetTies.grid.self:RefreshAllElement()
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
