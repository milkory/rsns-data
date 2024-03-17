local View = require("UIIncubator/UIIncubatorView")
local Controller = require("UIIncubator/UIIncubatorController")
local DataModel = require("UIIncubator/UIIncubatorDataModel")
local ViewFunction = require("UIIncubator/UIIncubatorViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.UID = Json.decode(initParams).ufid
    DataModel.FurnitureServerData = PlayerData.ServerData.user_home_info.furniture[DataModel.UID]
    local furniture = GetCA(DataModel.FurnitureServerData.id)
    print_r(furniture)
    if DataModel.FurnitureServerData.space and DataModel.FurnitureServerData.space.reward_ts then
      View.Group_PurificationEmpty:SetActive(false)
    else
      View.Group_PurificationEmpty:SetActive(true)
    end
    DataModel.CurrFurnitureConfig = PlayerData:GetFactoryData(DataModel.FurnitureServerData.id, "HomeFurnitureFactory")
    DataModel.IsOnlyOne = DataModel.CurrFurnitureConfig.PurificationsiloList == 1
    DataModel:Reset()
    View.Group_SelectionInterface.self:SetActive(false)
    DataModel.GetType()
    Controller:RefreshRight()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FurnitureServerData.space and DataModel.FurnitureServerData.space.reward_ts then
      Controller:RefreshHaveRight()
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
