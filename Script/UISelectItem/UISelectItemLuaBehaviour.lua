local View = require("UISelectItem/UISelectItemView")
local DataModel = require("UISelectItem/UISelectItemDataModel")
local ViewFunction = require("UISelectItem/UISelectItemViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Id = tonumber(initParams)
    DataModel.Data = PlayerData:GetFactoryData(DataModel.Id, "ItemFactory")
    DataModel.selectIdx = 1
    View.ScrollGrid_List.grid.self:SetDataCount(#DataModel.Data.exchangeList)
    View.ScrollGrid_List.grid.self:RefreshAllElement()
    ViewFunction.RefreshSelectRoleInfo()
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
