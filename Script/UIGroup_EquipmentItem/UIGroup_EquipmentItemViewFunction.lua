local View = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemView")
local DataModel = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemDataModel")
local ViewFunction = {
  Group_EquipmentItem_Btn_Black_Click = function(btn, str)
    local callback = function()
      UIManager:GoBack(DataModel.params.invokeInitParams)
    end
    DataModel:SendEquipLockData(callback)
  end,
  Group_EquipmentItem_Group_Lock_Btn_Unlock_Click = function(btn, str)
    DataModel:ClickLockBtn()
  end,
  Group_EquipmentItem_Group_Lock_Btn_Lock_Click = function(btn, str)
    DataModel:ClickLockBtn()
  end,
  Group_EquipmentItem_Btn_DropButton_Click = function(btn, str)
    local data = {}
    data.itemID = DataModel.itemId
    data.posX = 426
    data.posY = -60
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data), function()
    end)
  end,
  Group_EquipmentItem_Group_Two_Btn_Change_Click = function(btn, str)
    local callback = function()
      local hid = PlayerData:GetEquipById(DataModel.eid).hid
      local index = PlayerData:GetRoleEquipIndex(DataModel.eid)
      local roleCA = PlayerData:GetFactoryData(hid)
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", roleCA.equipmentSlotList[tonumber(index)].tagID)
      local params = {
        Type = typeInt,
        RoleId = hid,
        Index = index,
        RoleCA = roleCA
      }
      UIManager:ClosePanel(false, "UI/CharacterInfo/weapon/WeaponItemWindow/Group_EquipmentItem")
      CommonTips.OpenGroupWeapon(params)
    end
    DataModel:SendEquipLockData(callback)
  end,
  Group_EquipmentItem_Group_Two_Btn_Strengthen_Click = function(btn, str)
    local callback = function()
      local params = DataModel.params
      params.equipCA = DataModel.equipCA
      params.eid = DataModel.eid
      local tagCA = PlayerData:GetFactoryData(params.equipCA.equipTagId)
      params.tagCA = tagCA
      params.element = nil
      params.server.element = nil
      params.LeftTopTagIndex = 1
      UIManager:ClosePanel(false, "UI/CharacterInfo/weapon/WeaponItemWindow/Group_EquipmentItem")
      CommonTips.OpenGroupStrengthen(params)
    end
    DataModel:SendEquipLockData(callback)
  end,
  Group_EquipmentItem_Group_One_Btn_Strengthen_Click = function(btn, str)
    local callback = function()
      local params = DataModel.params
      params.equipCA = DataModel.equipCA
      params.eid = DataModel.eid
      local tagCA = PlayerData:GetFactoryData(params.equipCA.equipTagId)
      params.tagCA = tagCA
      params.element = nil
      params.server.element = nil
      params.LeftTopTagIndex = 1
      UIManager:ClosePanel(false, "UI/CharacterInfo/weapon/WeaponItemWindow/Group_EquipmentItem")
      CommonTips.OpenGroupStrengthen(params)
    end
    DataModel:SendEquipLockData(callback)
  end,
  Group_EquipmentItem_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
  end
}
return ViewFunction
