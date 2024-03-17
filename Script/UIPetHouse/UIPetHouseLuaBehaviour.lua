local View = require("UIPetHouse/UIPetHouseView")
local DataModel = require("UIPetHouse/UIPetHouseDataModel")
local ViewFunction = require("UIPetHouse/UIPetHouseViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode({
      ufid = DataModel.ufid
    })
  end,
  deserialize = function(initParams)
    local ufid = Json.decode(initParams).ufid
    DataModel.ufid = ufid
    local furniture = PlayerData.ServerData.user_home_info.furniture[ufid]
    DataModel.Init(furniture)
    DataModel.CalPetFurList()
    View.Group_CheckPets_List.StaticGrid_Rooms.grid.self:RefreshAllElement()
    ViewFunction.RefreshFoodInfo()
    View.Group_CheckPets_List.Group_HouseName.Img_HouseName.Txt_HouseName:SetText(DataModel.houseName)
    View.Group_ChangeHouse:SetActive(DataModel.petHouseCount > 1 and false)
    local fur_id = PlayerData:GetHomeInfo().furniture[DataModel.ufid].id
    local furCA = PlayerData:GetFactoryData(fur_id)
    local v3 = Vector3(furCA.checkCameraX, furCA.checkCameraY, furCA.checkCameraZ)
    HomeManager:CamFocusToFurniture(DataModel.ufid, v3, furCA.checkCameraTime, false, furCA.focusCamMove, function()
    end)
    View.Group_ChangeName:SetActive(false)
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
