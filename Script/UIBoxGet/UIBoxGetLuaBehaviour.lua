local View = require("UIBoxGet/UIBoxGetView")
local DataModel = require("UIBoxGet/UIBoxGetDataModel")
local ViewFunction = require("UIBoxGet/UIBoxGetViewFunction")
local CommonItem = require("Common/BtnItem")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local json = Json.decode(tostring(initParams))
    DataModel.Data = PlayerData:SortShowItem(json)
    local rewardNumber = table.count(DataModel.Data)
    if 0 < rewardNumber then
      View.StaticGrid_reward.grid.self:SetDataCount(rewardNumber)
      View.StaticGrid_reward.grid.self:RefreshAllElement()
      View.self:PlayAnimOnce("Animation_boxGetIn", function()
      end)
    end
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
