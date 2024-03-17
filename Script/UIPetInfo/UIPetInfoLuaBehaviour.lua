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
