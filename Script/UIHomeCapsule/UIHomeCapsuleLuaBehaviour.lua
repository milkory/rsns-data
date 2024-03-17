local View = require("UIHomeCapsule/UIHomeCapsuleView")
local DataModel = require("UIHomeCapsule/UIHomeCapsuleDataModel")
local Controller = require("UIHomeCapsule/UIHomeCapsuleController")
local HomeStoreDataModel = require("UIHomeCapsule/UIHomeStoreDataModel")
local HomeStoreController = require("UIHomeCapsule/UIHomeStoreController")
local ViewFunction = require("UIHomeCapsule/UIHomeCapsuleViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      Controller:ClearView()
      Controller:ChangeToView(t.viewType, true)
    elseif View.Group_HomeStore.self.IsActive then
      View.Group_HomeStore.Group_FurnitureStore.ScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_HomeStore.Group_Right.StaticGrid_BQ.grid.self:RefreshAllElement()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.rencentlyTime ~= 0 and TimeUtil:GetServerTimeStamp() > DataModel.rencentlyTime then
      Controller:TimeRefresh()
    end
  end,
  ondestroy = function()
    HomeStoreDataModel.List = {}
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
