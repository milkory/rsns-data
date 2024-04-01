local View = require("UIPetInfo/UIPetInfoView")
local DataModel = require("UIPetInfo/UIPetInfoDataModel")
local ViewFunction = require("UIPetInfo/UIPetInfoViewFunction")
local params = ""
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    local data = Json.decode(initParams)
    DataModel.Init(data)
    ViewFunction.UpdatePetInfo()
    View.Group_ChangePet:SetActive(DataModel.petCount > 1)
    View.Group_Snack:SetActive(false)
    View.Group_PetView.Group_Pet.Group_State:SetActive(false)
    View.Group_PetInfo.Group_Effect1:SetActive(false)
    View.Group_PetInfo.Group_Effect2:SetActive(false)
    View.Group_ChangeName:SetActive(false)
    local newPetBuff = {}
    local petIds = ""
    local petInfo = PlayerData:GetHomeInfo().pet[DataModel.pet_uid]
    if petInfo and petInfo.role_id ~= "" then
      local petBuffCount = petInfo.lv - 7
      local nowBuffCount = #petInfo.buff_list
      if 0 < petBuffCount - nowBuffCount then
        newPetBuff[DataModel.pet_uid] = petBuffCount - nowBuffCount
        petIds = DataModel.pet_uid
      end
    end
    if petInfo.lv > 7 and petInfo.role_id == "" then
      CommonTips.OnPromptConfirmOnly(80606032, 80600068, function()
        UIManager:Open("UI/HomePet/PetFeederList", Json.encode({
          u_pet = DataModel.pet_uid
        }))
      end)
      return
    end
    if next(newPetBuff) then
      Net:SendProto("pet.info", function(json)
        for k, v in pairs(json.pet) do
          PlayerData:GetHomeInfo().pet[k] = v
        end
        UIManager:Open("UI/HomePet/Screen_GetTies", Json.encode(newPetBuff))
        ViewFunction.UpdateTieInfo()
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
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
