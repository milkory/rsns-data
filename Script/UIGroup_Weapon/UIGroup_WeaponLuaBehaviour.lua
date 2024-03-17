local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local DataModel = require("UIGroup_Weapon/UIGroup_WeaponDataModel")
local ViewFunction = require("UIGroup_Weapon/UIGroup_WeaponViewFunction")
local Luabehaviour = {
  serialize = function()
    local param = {}
    param.RoleCA = DataModel.RoleCA
    param.RoleId = DataModel.RoleId
    DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
    param.Index = DataModel.RoleEquipIndex
    param.Type = DataModel.RoleEquipType
    return Json.encode(param)
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel.RoleCA = param.RoleCA
    DataModel.RoleId = tostring(param.RoleId)
    DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
    DataModel.RoleEquipIndex = param.Index or 1
    DataModel.RoleEquipType = param.Type
    View.Group_Detail.self:SetActive(false)
    View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(true)
    View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(false)
    DataModel.LeftTopTagName = {}
    local EquipTypeList = PlayerData:GetFactoryData(99900027).EquipTypeList
    for k, v in pairs(EquipTypeList) do
      local ca = PlayerData:GetFactoryData(v.id)
      table.insert(DataModel.LeftTopTagName, ca.Name)
    end
    DataModel:ClosePresets(false, true)
    DataModel.OldEquipData = {}
    DataModel:RefreshAllRoleData()
    DataModel.LeftTopTagIndex = nil
    DataModel.EquipIndex = nil
    DataModel.ChooseLeftTop(DataModel.RoleEquipIndex)
    DataModel:Load()
    View.self:PlayAnim("In_Equipment")
    View.Group_Center.Btn_Detail.self:SetActive(false)
    View.Group_Center.Group_Compare.self:SetActive(false)
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
