local View = require("UIPlantEdition/UIPlantEditionView")
local DataModel = require("UIPlantEdition/UIPlantEditionDataModel")
local ViewFunction = require("UIPlantEdition/UIPlantEditionViewFunction")
local Controller = require("UIPlantEdition/UIPlantEditionController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local json = Json.decode(initParams)
    DataModel.UID = json.ufid
    DataModel.IsOnlyShow = json.onlyShow
    if DataModel.IsOnlyShow then
      View.Group_Edition.self:SetActive(false)
      View.Group_Top.Btn_Mood.self:SetActive(false)
      return
    else
      View.Group_Edition.self:SetActive(true)
      View.Group_Top.Btn_Mood.self:SetActive(true)
    end
    DataModel.FurnitureServerData = PlayerData.ServerData.user_home_info.furniture[DataModel.UID]
    local furniture = GetCA(DataModel.FurnitureServerData.id)
    DataModel.Index = 0
    DataModel.Seeds = {}
    DataModel.Sort = 0
    if DataModel.FurnitureServerData.plants then
      DataModel.Seeds = Clone(DataModel.FurnitureServerData.plants)
    end
    DataModel:InitData()
    DataModel:SortRule()
    DataModel.IsOpenTab = false
    View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:SetDataCount(#DataModel.Plants)
    View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:RefreshAllElement()
    View.Group_Edition.StaticGrid_AddAndDelete.grid.self:SetDataCount(furniture.PlantsNum)
    View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.IsOnlyShow then
      return
    end
    Controller:RefreshTop()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
