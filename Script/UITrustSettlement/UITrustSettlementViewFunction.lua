local View = require("UITrustSettlement/UITrustSettlementView")
local DataModel = require("UITrustSettlement/UITrustSettlementDataModel")
local ViewFunction = {
  TrustSettlement_Btn_Close_Click = function(btn, str)
    if DataModel.curFrame < 80 then
      return
    end
    UIManager:GoBack(false)
    local mealCA = PlayerData:GetFactoryData(DataModel.mealId)
    if #mealCA.speed > 0 then
      UIManager:Open("UI/HomeKeepFastFood/SpeedSettlement", Json.encode({
        bgmId = DataModel.bgmId,
        mealId = DataModel.mealId,
        hasBattle = 0 < #mealCA.battleBuffList
      }))
    elseif 0 < #mealCA.battleBuffList then
      UIManager:Open("UI/HomeKeepFastFood/BattleSettlement", Json.encode({
        bgmId = DataModel.bgmId,
        mealId = DataModel.mealId
      }))
    else
      if DataModel.bgmId and 0 < DataModel.bgmId then
        local sound = SoundManager:CreateSound(DataModel.bgmId)
        if sound ~= nil then
          sound:Play()
        end
      end
      HomeStationStoreManager:AfterStorePlay()
    end
  end,
  TrustSettlement_Group_CharacterExp_StaticGrid_Character_SetGrid = function(element, elementIndex)
    local roleInfo = DataModel.roleList[elementIndex]
    if roleInfo then
      local isLvMax = false
      if (PlayerData:GetRoleById(roleInfo.roleId).trust_lv or 1) >= 10 then
        isLvMax = true
      end
      element.Group_Trust:SetActive(not isLvMax)
      element.Group_Character01.Group_LevelUp:SetActive(not isLvMax)
      element.Group_Character01.Txt_LevelMax:SetActive(isLvMax)
      element:SetActive(true)
      local unitCA = PlayerData:GetFactoryData(roleInfo.roleId, "UnitFactory")
      local viewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
      local face = viewCA.face
      element.Group_Character01.Img_Mask.Img_Face:SetSprite(face)
      element.Group_Character01.Group_LevelUp:SetActive(roleInfo.lv_up)
      element.Group_Trust.Txt_Num:SetText(string.format(GetText(80601584), roleInfo.add_trust))
      element.Group_Character01.Group_Lv.Txt_Num:SetText(PlayerData:GetRoleById(roleInfo.roleId).trust_lv or 1)
    else
      element:SetActive(false)
    end
  end
}
return ViewFunction
