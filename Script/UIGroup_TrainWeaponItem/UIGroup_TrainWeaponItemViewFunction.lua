local View = require("UIGroup_TrainWeaponItem/UIGroup_TrainWeaponItemView")
local DataModel = require("UIGroup_TrainWeaponItem/UIGroup_TrainWeaponItemDataModel")
local ViewFunction = {
  Group_TrainWeaponItem_Btn_Black_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  Group_TrainWeaponItem_StaticGrid_MonsterType_SetGrid = function(element, elementIndex)
    local cfg = PlayerData:GetFactoryData(DataModel.weaponId)
    local hitEventType = cfg.hitEventType
    if hitEventType[elementIndex] then
      element:SetActive(true)
      local tagCa = PlayerData:GetFactoryData(hitEventType[elementIndex].id)
      element:SetSprite(tagCa.icon)
    else
      element:SetActive(false)
    end
  end,
  Group_TrainWeaponItem_Group_Lock_Btn_Unlock_Click = function(btn, str)
  end,
  Group_TrainWeaponItem_Group_Lock_Btn_Lock_Click = function(btn, str)
  end,
  Group_TrainWeaponItem_Btn_DropButton_Click = function(btn, str)
    local data = {}
    data.itemID = DataModel.weaponId
    data.posX = 400
    data.posY = -40
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
  end,
  Group_TrainWeaponItem_ScrollView_Content_Viewport_Content_Group_Need_StaticGrid_Type_SetGrid = function(element, elementIndex)
    local coretypeList = PlayerData:GetFactoryData(99900044).coretypeList
    local cfg = PlayerData:GetFactoryData(coretypeList[elementIndex].id)
    element:SetSprite(cfg.coreIconPathW)
    local weaponCA = PlayerData:GetFactoryData(DataModel.weaponId, "HomeWeaponFactory")
    element:SetAlpha(0.4)
    element.Txt_Level:SetActive(false)
    local needCoreList = weaponCA.coreList
    for k, v in pairs(needCoreList) do
      if v.id == coretypeList[elementIndex].id then
        element:SetAlpha(1)
        element.Txt_Level:SetActive(true)
        element.Txt_Level:SetText("LV" .. v.level)
        break
      end
    end
  end,
  Group_TrainWeaponItem_Group_Two_Btn_Change_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if not funcCommon.FuncActiveCheck(108, true) then
      CommonTips.OpenTips(80602516)
      return
    end
    if PlayerData.IsInStation() == false then
      CommonTips.OpenTips(80602517)
      return
    end
    UIManager:GoBack(false)
    local CarriageDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
    local t = {
      CurrTag = CarriageDataModel.TagType.Weapon
    }
    CommonTips.OpenToHomeCarriageeditor(t)
  end,
  Group_TrainWeaponItem_Group_Two_Btn_Strengthen_Click = function(btn, str)
    local data = {
      uid = DataModel.weaponUid
    }
    UIManager:GoBack(false)
    UIManager:Open("UI/Trainfactory/Group_TrainWeaponSth", Json.encode(data), function()
      View.self:Confirm()
    end)
  end
}
return ViewFunction
