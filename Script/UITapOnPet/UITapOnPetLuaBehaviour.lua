local View = require("UITapOnPet/UITapOnPetView")
local DataModel = require("UITapOnPet/UITapOnPetDataModel")
local ViewFunction = require("UITapOnPet/UITapOnPetViewFunction")
local Luabehaviour = {
  serialize = function()
    return DataModel.Id
  end,
  deserialize = function(initParams)
    DataModel.Id = initParams
    local pet = PlayerData.ServerData.user_home_info.pet[DataModel.Id]
    DataModel.PetConfig = PlayerData:GetFactoryData(99900022, "ConfigFactory")
    View.Btn_Touch.Txt_TouchTimes:SetText(pet.interact_num .. "/" .. DataModel.PetConfig.TouchTimes)
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
