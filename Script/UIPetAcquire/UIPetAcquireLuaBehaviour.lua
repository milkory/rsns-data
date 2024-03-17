local View = require("UIPetAcquire/UIPetAcquireView")
local DataModel = require("UIPetAcquire/UIPetAcquireDataModel")
local ViewFunction = require("UIPetAcquire/UIPetAcquireViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.PetInfo = Json.decode(initParams)
    local serverPetInfo = PlayerData:GetHomePet()[DataModel.PetInfo.uid]
    DataModel.PetInfo.id = tonumber(serverPetInfo.id)
    local petCA = PlayerData:GetFactoryData(DataModel.PetInfo.id, "PetFactory")
    View.Img_Pet:SetSprite(petCA.petIconPath)
    local tagCA = PlayerData:GetFactoryData(petCA.petVarity, "TagFactory")
    View.Img_Back.Img_Info.Img_Species:SetSprite(tagCA.icon)
    View.Img_Back.Img_Info.InputField_:SetText(petCA.petName)
    View.Img_Back.Img_Info.Group_CommonInfo.Group_PetScores.Txt_:SetText(petCA.petBaseScore)
    local tagPersonalityCA = PlayerData:GetFactoryData(serverPetInfo.personality, "TagFactory")
    View.Img_Back.Img_Info.Group_CommonInfo.Group_Personality.Txt_:SetText(tagPersonalityCA.petPersonalityName)
    View.Img_Back.Img_Info.Group_CommonInfo.Group_PetFoodInt.Txt_:SetText(string.format(GetText(80600742), petCA.petFoodInt))
    View.Img_Back.Img_Info.Group_CommonInfo.Group_PetGarbage.Txt_:SetText(string.format(GetText(80601006), petCA.wasteoutput))
    View.Img_Back.Img_Des.Txt_Des:SetText(petCA.des)
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
