local View = require("UIGroup_Strengthen/UIGroup_StrengthenView")
local DataModel = require("UIGroup_Strengthen/UIGroup_StrengthenDataModel")
local ViewFunction = require("UIGroup_Strengthen/UIGroup_StrengthenViewFunction")
local Luabehaviour = {
  serialize = function()
    return DataModel.initParams
  end,
  deserialize = function(initParams)
    DataModel.initParams = initParams
    local param = Json.decode(initParams)
    DataModel.server = param.server
    DataModel.LeftTopTagIndex = param.LeftTopTagIndex
    DataModel.equipCA = param.equipCA
    DataModel.tagCA = param.tagCA
    DataModel.eid = param.eid
    DataModel.EquipFactory = PlayerData:GetFactoryData(99900027)
    DataModel.Max_Equip_Lv = DataModel.EquipFactory.equipMaxLv
    DataModel.TypeIndex = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.equipCA.equipTagId)
    DataModel.JewelryEx = 1
    if DataModel.TypeIndex == 3 then
      DataModel.JewelryEx = DataModel.EquipFactory.jewelryEx
    end
    DataModel.Max_Affix_Num = PlayerData:GetFactoryData(DataModel.equipCA.equipTagId).typeName
    View.Group_UseMoney.self:SetActive(false)
    View.Group_Windows.self:SetActive(false)
    View.Group_Detail.self:SetActive(false)
    View.Group_Left.self:SetActive(false)
    DataModel:InitEquipList()
    DataModel:RefreshRightContent()
    DataModel.delay_ani_time = -1
    DataModel.AniState = false
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.AniState == false then
      return
    end
    if DataModel.delay_ani_time > 0 then
      DataModel.delay_ani_time = DataModel.delay_ani_time - 1
      DataModel:RefreshAniSetFilledImgAmount()
    end
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
