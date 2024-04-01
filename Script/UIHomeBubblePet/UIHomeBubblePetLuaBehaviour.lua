local View = require("UIHomeBubblePet/UIHomeBubblePetView")
local DataModel = require("UIHomeBubblePet/UIHomeBubblePetDataModel")
local ViewFunction = require("UIHomeBubblePet/UIHomeBubblePetViewFunction")
local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.uId = Json.decode(initParams).uId
      local petData
      for i, v in pairs(PlayerData.ServerData.user_home_info.pet) do
        if i == DataModel.uId then
          petData = v
          DataModel.uFid = v.u_fid
          break
        end
      end
      View.Group_Panel.Img_BubbleBG.Group_Title.Group_Master:SetActive(petData.role_id ~= "")
      if petData.role_id ~= "" then
        local unitCA = PlayerData:GetFactoryData(petData.role_id, "UnitFactory")
        local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
        View.Group_Panel.Img_BubbleBG.Group_Title.Group_Master.Img_Mask.Img_Face:SetSprite(unitViewCA.face)
      end
      if petData then
        local name = petData.name ~= "" and petData.name or PlayerData:GetFactoryData(petData.id, "PetFactory").petName
        View.Group_Panel.Img_BubbleBG.Group_Title.Txt_Title:SetText(name)
        View.Group_Panel.Img_BubbleBG.Group_List.Group_Attribute1.Group_Level.Txt_Scores:SetText(petData.lv)
        local petInfo = PlayerData:GetHomeInfo().pet[DataModel.uId]
        local scores = ClearFollowZero(PetInfoData.CalPetScores(petInfo))
        View.Group_Panel.Img_BubbleBG.Group_List.Group_Attribute2.Txt_Scores:SetText("+" .. scores)
      end
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
