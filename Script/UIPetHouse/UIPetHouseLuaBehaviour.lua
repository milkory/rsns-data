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
    local newPetBuff = {}
    local petIds = ""
    for k, v in pairs(DataModel.petList) do
      local petInfo = PlayerData:GetHomeInfo().pet[v]
      if petInfo and petInfo.role_id ~= "" then
        local petBuffCount = petInfo.lv - 7
        local nowBuffCount = #petInfo.buff_list
        if 0 < petBuffCount - nowBuffCount then
          newPetBuff[v] = petBuffCount - nowBuffCount
          if petIds == "" then
            petIds = v
          else
            petIds = petIds .. "," .. v
          end
        end
      end
    end
    if next(newPetBuff) then
      Net:SendProto("pet.info", function(json)
        for k, v in pairs(json.pet) do
          PlayerData:GetHomeInfo().pet[k] = v
        end
        UIManager:Open("UI/HomePet/Screen_GetTies", Json.encode(newPetBuff))
      end, petIds)
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
