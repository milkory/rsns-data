local View = require("UITapOnPet/UITapOnPetView")
local DataModel = require("UITapOnPet/UITapOnPetDataModel")
local ViewFunction = {
  TapOnPet_Btn_Close_Click = function(btn, str)
    View.self:SetActive(false)
  end,
  TapOnPet_Btn_Feed_Click = function(btn, str)
    Net:SendProto("pet.feed", function(json)
      for i, v in pairs(json.pet) do
        PlayerData.ServerData.user_home_info.pet[i] = v
      end
      View.self:SetActive(false)
      CommonTips.OpenShowItem(json.reward)
    end, DataModel.Id)
  end,
  TapOnPet_Btn_Info_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetInfo", tostring(DataModel.Id))
  end,
  TapOnPet_Btn_Hide_Click = function(btn, str)
  end,
  TapOnPet_Btn_Touch_Click = function(btn, str)
    Net:SendProto("pet.interact", function(json)
      for i, v in pairs(json.pet) do
        PlayerData.ServerData.user_home_info.pet[i] = v
        View.Btn_Touch.Txt_TouchTimes:SetText(v.interact_num .. "/" .. DataModel.PetConfig.TouchTimes)
      end
    end, DataModel.Id)
  end
}
return ViewFunction
