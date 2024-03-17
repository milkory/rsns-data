local View = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemView")
local DataModel = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemDataModel")
local ViewFunction = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemViewFunction")
local notGet = function()
  View.Group_Show.self:SetLocalPositionY(0)
end
local CA
local haveGet = function()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Change.self:SetActive(true)
end
local changeGet = function()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Strengthen.self:SetActive(true)
end
local buttomState = {
  [0] = notGet,
  [1] = haveGet,
  [2] = changeGet
}
local init = function(parms)
  CA = PlayerData:GetFactoryData(parms.id)
  View.Img_FlagRare.Img_Equipment:SetSprite(parms.tipsPath)
  View.Img_FlagRare:SetSprite(UIConfig.TipConfig[tonumber(parms.qualityInt + 1)])
  View.Img_Rare:SetSprite(UIConfig.WeaponQuality[tonumber(parms.qualityInt + 1)])
  View.Img_Rare:SetNativeSize()
  View.Group_Equipment.Txt_EquipmentNum:SetText(parms.name)
  View.Group_Equipment.Txt_EquipmentLevel:SetText("LV " .. parms.server.lv)
  local index = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.equipCA.equipTagId)
  View.Img_EquipmentIcom:SetSprite(UIConfig.EquipmentTypeMark[index])
  View.Group_Lock.self:SetActive(true)
  View.Group_Lock.Btn_Lock:SetActive(false)
  View.Group_Lock.Btn_Unlock:SetActive(false)
  DataModel.isLockState = 0
  if DataModel.params.server.is_locked == 0 then
    View.Group_Lock.Btn_Unlock:SetActive(true)
    DataModel.isLockState = 0
  else
    View.Group_Lock.Btn_Lock:SetActive(true)
    DataModel.isLockState = 1
  end
  View.Group_Two.self:SetActive(false)
  View.Group_One.self:SetActive(false)
  View.Img_whoBg:SetActive(false)
  if parms.server.hid and parms.server.hid ~= "" then
    View.Group_Two.self:SetActive(true)
    View.Txt_Character:SetActive(true)
    local name = PlayerData:GetFactoryData(parms.server.hid).name
    View.Img_whoBg:SetActive(true)
    View.Txt_Character:SetText(string.format(GetText(80600429), name))
  else
    View.Group_One.self:SetActive(true)
    View.Txt_Character:SetActive(false)
  end
  DataModel:RefreshRightContent()
  if DataModel.params.isPre then
    View.Group_Two.self:SetActive(false)
    View.Group_One.self:SetActive(false)
    View.Group_Lock.self:SetActive(false)
  end
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      DataModel.params = data
      DataModel.isChangeLock = false
      DataModel.eid = data.eid
      DataModel.itemId = data.id
      DataModel.equipCA = PlayerData:GetFactoryData(data.id)
      DataModel.EquipFactory = PlayerData:GetFactoryData(99900027)
      DataModel.Max_Affix_Num = PlayerData:GetFactoryData(DataModel.equipCA.equipTagId).typeName
      init(data)
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
