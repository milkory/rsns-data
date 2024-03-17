local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local DataModel = require("UIGroup_Weapon/UIGroup_WeaponDataModel")
local ViewFunction = {
  Group_Weapon_Group_Center_Btn_Compare_Click = function(btn, str)
    local callBack = function()
      DataModel:OpenEquipCompare()
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Center_Btn_Presets_Click = function(btn, str)
    local callBack = function()
      DataModel:OpenPresets()
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Center_Btn_Detail_Click = function(btn, str)
  end,
  Group_Weapon_Group_Center_Group_Compare_Btn_Lock_Click = function(btn, str)
    local row = DataModel.MySelfEquip.server
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.MySelfEquip.eid).is_locked = 0
      if DataModel.isPresets == false and DataModel.OldEquipData.index then
        View.Group_Left.ScrollGrid_Item.grid[DataModel.OldEquipData.index].Group_Equipment.Img_Lock:SetActive(false)
      end
      View.Group_Center.Group_Compare.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Center.Group_Compare.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.MySelfEquip.eid).is_locked = 1
      if DataModel.isPresets == false and DataModel.OldEquipData.index then
        View.Group_Left.ScrollGrid_Item.grid[DataModel.OldEquipData.index].Group_Equipment.Img_Lock:SetActive(true)
      end
      View.Group_Center.Group_Compare.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Center.Group_Compare.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if DataModel.MySelfEquip.server.is_locked == DataModel.MySelfEquip.old_locked then
      DataModel.MySelfEquip.isChange = 0
    else
      DataModel.MySelfEquip.isChange = 1
    end
  end,
  Group_Weapon_Group_Center_Group_Compare_Btn_Tips_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Weapon_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Armor_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Ring_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.NowList[tonumber(elementIndex)]
    DataModel.ShowNowList[tonumber(elementIndex)] = {}
    DataModel.ShowNowList[tonumber(elementIndex)].element = element
    element.Group_Equipment.Btn_Item:SetClickParam(elementIndex)
    element.Group_Equipment.Img_Item:SetSprite(row.equipCA.iconPath)
    element.Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[row.equipCA.qualityInt + 1])
    element.Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.equipCA.qualityInt + 1])
    element.Group_Equipment.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), row.server.lv))
    element.Group_Equipment.Img_Select:SetActive(false)
    element.Group_Equipment.Group_Face:SetActive(false)
    if row.server.hid ~= "" then
      element.Group_Equipment.Group_Face:SetActive(true)
      element.Group_Equipment.Group_Face.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(row.server.hid).viewId).face)
      if row.server.hid == DataModel.RoleId then
        local old = {}
        old.index = elementIndex
        old.eid = row.eid
        old.element = element
        DataModel.OldEquipData = old
      end
    end
    element.Group_Equipment.Img_Lock:SetActive(false)
    if row.server.is_locked == 1 then
      element.Group_Equipment.Img_Lock:SetActive(true)
    end
    element.Group_Equipment.Img_NoType:SetActive(false)
    if row.index == 2 then
      element.Group_Equipment.Img_NoType:SetActive(true)
    end
    if DataModel.EquipIndex and DataModel.EquipIndex == tonumber(elementIndex) then
      element.Group_Equipment.Img_Select:SetActive(true)
    end
  end,
  Group_Weapon_Group_Left_Btn_Search_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Sort_Click = function(btn, str)
    local callBack = function()
      DataModel:SortButton()
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Right_Btn_Lock_Click = function(btn, str)
    local row = DataModel.SendLockList[DataModel.NowChooseEquip.eid]
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).is_locked = 0
      if DataModel.isPresets == false then
        DataModel.ShowNowList[tonumber(DataModel.EquipIndex)].element.Group_Equipment.Img_Lock:SetActive(false)
      end
      View.Group_Right.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Right.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).is_locked = 1
      if DataModel.isPresets == false then
        DataModel.ShowNowList[tonumber(DataModel.EquipIndex)].element.Group_Equipment.Img_Lock:SetActive(true)
      end
      View.Group_Right.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Right.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if row.is_locked == row.old_locked then
      row.isChange = 0
    else
      row.isChange = 1
    end
  end,
  Group_Weapon_Group_Right_Btn_Tips_Click = function(btn, str)
  end,
  Group_Weapon_Group_Right_Btn_Strengthen_Click = function(btn, str)
    local callBack_a = function()
      local callBack = function()
        local params = DataModel.NowChooseEquip
        params.element = nil
        params.server.element = nil
        params.LeftTopTagIndex = DataModel.LeftTopTagIndex
        CommonTips.OpenGroupStrengthen(params)
      end
      DataModel:SendEquipLockData(callBack)
    end
    if View.Group_Center.Group_Compare.self.IsActive == true then
      DataModel:OpenEquipCompare(true, callBack_a)
      return
    end
    callBack_a()
  end,
  Group_Weapon_Group_Right_Btn_Removing_Click = function(btn, str)
    if View.Group_Center.Group_Compare.self.IsActive == true then
      DataModel:OpenEquipCompare()
    end
    Net:SendProto("hero.set_equip", function(json)
      PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = ""
      DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = ""
      if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
        DataModel.OldEquipData.element.Group_Equipment.Group_Face:SetActive(false)
        PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
      end
      DataModel.MySelfEquip = {}
      DataModel.MySelfEquip.eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
      DataModel.MySelfEquip.equipCA = PlayerData:GetEquipById(DataModel.MySelfEquip.eid) ~= nil and PlayerData:GetFactoryData(PlayerData:GetEquipById(DataModel.MySelfEquip.eid).id) or {}
      DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
      DataModel.OldEquipData = {}
      DataModel.RefreshRightContent(View.Group_Right, 1)
    end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 1)
  end,
  Group_Weapon_Group_Right_Btn_Use_Click = function(btn, str)
    local callBack = function()
      Net:SendProto("hero.set_equip", function(json)
        print_r(json)
        PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = DataModel.NowChooseEquip.eid
        PlayerData:GetRoleById(DataModel.SendRoleID).equips[DataModel.RoleEquipIndex] = ""
        PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = DataModel.RoleId
        DataModel.MySelfEquip = {}
        DataModel.MySelfEquip.eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
        DataModel.MySelfEquip.equipCA = PlayerData:GetEquipById(DataModel.MySelfEquip.eid) ~= nil and PlayerData:GetFactoryData(PlayerData:GetEquipById(DataModel.MySelfEquip.eid).id) or {}
        DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
        if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
          DataModel.OldEquipData.element.Group_Equipment.Group_Face:SetActive(false)
          PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
        end
        local row = {}
        row.index = DataModel.EquipIndex
        row.eid = DataModel.NowChooseEquip.eid
        row.element = DataModel.ShowNowList[DataModel.EquipIndex].element
        row.element.Group_Equipment.Group_Face:SetActive(true)
        row.element.Group_Equipment.Group_Face.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(DataModel.RoleId).viewId).face)
        DataModel.OldEquipData = row
        if View.Group_Center.Group_Compare.self.IsActive == true then
          DataModel:OpenEquipCompare()
        end
        DataModel.RefreshRightContent(View.Group_Right, 1)
      end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 0)
    end
    if DataModel.SendRoleIsSelf == false then
      local content = string.format(GetText(80600448), PlayerData:GetFactoryData(DataModel.SendRoleID).name)
      CommonTips.OnPrompt(content, nil, nil, callBack)
      return
    end
    local equipTagId = DataModel.NowChooseEquip.equipCA.equipTagId
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipTagId)
    if typeInt ~= DataModel.RoleEquipType then
      CommonTips.OpenTips(80600267)
      return
    end
    Net:SendProto("hero.set_equip", function(json)
      print_r(json)
      PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = DataModel.NowChooseEquip.eid
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = DataModel.RoleId
      DataModel.MySelfEquip = {}
      DataModel.MySelfEquip.eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
      DataModel.MySelfEquip.equipCA = PlayerData:GetEquipById(DataModel.MySelfEquip.eid) ~= nil and PlayerData:GetFactoryData(PlayerData:GetEquipById(DataModel.MySelfEquip.eid).id) or {}
      DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
      if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
        DataModel.OldEquipData.element.Group_Equipment.Group_Face:SetActive(false)
        PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
      end
      local row = {}
      row.index = DataModel.EquipIndex
      row.eid = DataModel.NowChooseEquip.eid
      row.element = DataModel.ShowNowList[DataModel.EquipIndex].element
      row.element.Group_Equipment.Group_Face:SetActive(true)
      row.element.Group_Equipment.Group_Face.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(DataModel.RoleId).viewId).face)
      DataModel.OldEquipData = row
      if View.Group_Center.Group_Compare.self.IsActive == true then
        DataModel:OpenEquipCompare()
      end
      DataModel.RefreshRightContent(View.Group_Right, 1)
    end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 0)
  end,
  Group_Weapon_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
    local callBack = function()
      DataModel:ChooseEquip(tonumber(str))
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    local callBack = function()
      if DataModel.isPresets == true then
        View.Group_Detail.self:SetActive(false)
        DataModel:ClosePresets(1)
        local index = DataModel.LeftTopTagIndex
        DataModel.LeftTopTagIndex = nil
        DataModel.ChooseLeftTop(index)
        return
      end
      if View.Group_Center.Group_Compare.self.IsActive == true then
        View.self:PlayAnim("Out_Compare", function()
          UIManager:GoBack()
        end)
      else
        UIManager:GoBack()
      end
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    local callBack = function()
      UIManager:GoHome()
    end
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.LeftTopTagName[tonumber(elementIndex)]
    local Img_Close = element.Btn_Item.Img_Close
    Img_Close.Txt_CWeapon:SetText(row)
    local Img_Open = element.Btn_Item.Img_Open
    Img_Open.Txt_OWeapon:SetText(row)
    element.Btn_Item:SetClickParam(elementIndex)
    if elementIndex == DataModel.LeftTopTagIndex then
      Img_Open:SetActive(true)
      Img_Close:SetActive(false)
    else
      Img_Open:SetActive(false)
      Img_Close:SetActive(true)
    end
  end,
  Group_Weapon_Group_Right_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
  end,
  Group_Weapon_Group_Center_Group_Compare_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_SetGrid = function(element, elementIndex)
    local Btn_Presets = element.Btn_Presets
    if tonumber(elementIndex) == 1 then
      Btn_Presets.Btn_Use:SetActive(false)
      Btn_Presets.Txt_PresetsName:SetText("当前装备")
    else
      Btn_Presets.Btn_Use:SetActive(true)
      Btn_Presets.Txt_PresetsName:SetText("预设" .. elementIndex - 1)
    end
    Btn_Presets.Img_Select:SetActive(false)
    if DataModel.PresetIndex and DataModel.PresetIndex == tonumber(elementIndex) then
      Btn_Presets.Img_Select:SetActive(true)
    end
    DataModel.PresetListElement[elementIndex] = element
    Btn_Presets:SetClickParam(elementIndex)
    Btn_Presets.Btn_Use:SetClickParam(elementIndex)
    for i = 1, 3 do
      DataModel:SetEquipElement(Btn_Presets, elementIndex, i)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Click = function(btn, str)
    DataModel:ChoosePresetsGroup(str)
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Btn_Use_Click = function(btn, str)
    DataModel:ChoosePresetsGroup(str)
    DataModel:UsePresets(tonumber(str))
  end,
  Group_Weapon_Group_Left_Presets_Btn_Detail_Click = function(btn, str)
    DataModel:ClickDetail()
  end,
  Group_Weapon_Group_Left_Presets_Btn_Save_Click = function(btn, str)
    if tonumber(str) == 1 then
      return
    end
    local choose_equip = DataModel.PresetListElementData[DataModel.PresetIndex]
    local now_equip = DataModel.PresetListElementData[1]
    local list = {}
    local count = 0
    for k, v in pairs(now_equip) do
      table.insert(list, v)
    end
    for c, d in pairs(choose_equip) do
      if d ~= "" then
        count = count + 1
      end
    end
    local num, row = table:Difference(choose_equip, list)
    if 0 < num then
      local callBack = function()
        local connect = ","
        local equipList = ""
        for i = 1, table.count(list) do
          local v = list[i]
          equipList = equipList .. v .. connect
        end
        equipList = string.sub(equipList, 1, string.len(equipList) - 1)
        Net:SendProto("hero.save", function(json)
          print_r(json)
          PlayerData:GetRoleById(DataModel.RoleId).pre_equips[DataModel.PresetIndex - 1] = list
          DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
          DataModel.PresetListElementData[DataModel.PresetIndex] = list
          for i = 1, 3 do
            DataModel:SetEquipElement(DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets, DataModel.PresetIndex, i)
          end
          local index = DataModel.PresetIndex
          DataModel.PresetIndex = nil
          DataModel:ChoosePresetsGroup(index)
        end, DataModel.RoleId, equipList, DataModel.PresetIndex - 2)
      end
      if count == 0 then
        callBack()
      else
        CommonTips.OnPrompt(80600470, nil, nil, callBack)
      end
    end
  end,
  Group_Weapon_Group_Left_Presets_Btn_Delete_Click = function(btn, str)
    if View.Group_Left_Presets.Btn_Delete.Img_Open.IsActive == true then
      local callBack = function()
        local clear_equip = {
          [1] = "",
          [2] = "",
          [3] = ""
        }
        Net:SendProto("hero.save", function(json)
          print_r(json)
          PlayerData:GetRoleById(DataModel.RoleId).pre_equips[DataModel.PresetIndex - 1] = clear_equip
          DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
          DataModel.PresetListElementData[DataModel.PresetIndex] = clear_equip
          for i = 1, 3 do
            DataModel:SetEquipElement(DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets, DataModel.PresetIndex, i)
          end
          local index = DataModel.PresetIndex
          DataModel.PresetIndex = nil
          DataModel:ChoosePresetsGroup(index)
        end, DataModel.RoleId, ",,", DataModel.PresetIndex - 2)
      end
      CommonTips.OnPrompt(80600471, nil, nil, callBack)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_1_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][1]
    if DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(true)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(1)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_2_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][2]
    if DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_2.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(true)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(2)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_3_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][3]
    if DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_3.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(true)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
      DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(3)
    end
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_Weapon_Btn_CloseTips_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Weapon_Group_Left_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_StaticGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local callBack = function()
      DataModel.ChooseLeftTop(tonumber(str))
    end
    DataModel:SendEquipLockData(callBack)
  end
}
return ViewFunction
