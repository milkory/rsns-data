local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local DataModel = {
  InfoInitPos = {
    isRecord = true,
    x = 0,
    y = 0,
    scale = 1,
    offsetX = 0,
    offsetY = 1
  }
}
DataModel.LeftTopTag = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
DataModel.LeftTopTagName = {
  [1] = "武器",
  [2] = "护甲",
  [3] = "饰品"
}
DataModel.EquipTypeIcon = {
  [1] = "UI\\CharacterInfo\\weapon\\Weapon",
  [2] = "UI\\CharacterInfo\\weapon\\Armor",
  [3] = "UI\\CharacterInfo\\weapon\\Ornament"
}
DataModel.PropertyBase = {
  [1] = {
    growthType = "gAtk_SN",
    type = "attack_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_attack",
    name = "攻击力"
  },
  [2] = {
    growthType = "gHp_SN",
    type = "healthPoint_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_health",
    name = "生命力"
  },
  [3] = {
    growthType = "gDef_SN",
    type = "defence_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_defense",
    name = "防御力"
  }
}
DataModel.EntryMaxNum = {
  [1] = "Weapon",
  [2] = "Armor",
  [3] = "Ornaments"
}
local Clear = function()
  if DataModel.AffixList_1 then
    for k, v in pairs(DataModel.AffixList_1) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear_Center()
  if DataModel.AffixList_2 then
    for k, v in pairs(DataModel.AffixList_2) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear_Detail()
  if DataModel.AffixList_Detail then
    for k, v in pairs(DataModel.AffixList_Detail) do
      Object.Destroy(v)
    end
  end
end

local baseDesHight = 24
local SetDownAffix = function(obj, row, index)
  local v1 = obj.transform:Find("Txt_Entry_1")
  local v2 = v1.transform:GetComponent(typeof(CS.Seven.UITxt))
  v2:SetText(row.descriptionShow)
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetDownAllAffix = function(Content, AffixList, index)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = -60
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 668
  local space = 0
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  local Group_Entry = "UI/CharacterInfo/weapon/Group_Entry_Weapon"
  space = top_des_height
  DataModel["AffixList_" .. index] = {}
  local random_affix = AffixList
  if 0 < table.count(random_affix) then
    for i = 0, table.count(random_affix) - 1 do
      local talentCA = {}
      talentCA = PlayerData:GetFactoryData(random_affix[tostring(i)].id)
      if random_affix[tostring(i)].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(random_affix[tostring(i)].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 47
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel["AffixList_" .. index], obj)
      local hight_des = SetDownAffix(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Right.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:RefreshChooseRoleEquip(now_equip)
  DataModel.AllEquip = {}
  local list = PlayerData:GetEquips()
  if table.count(list) > 0 then
    for k, v in pairs(list) do
      local equipCA = PlayerData:GetFactoryData(v.id)
      local eid = k
      local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
      if v.hid == DataModel.RoleId then
        v.hid = ""
        for c, d in pairs(now_equip) do
          if d == k then
            v.hid = DataModel.RoleId
          end
        end
      end
      local row = {}
      row.eid = eid
      row.equipCA = equipCA
      row.tagCA = tagCA
      row.server = v
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
      if DataModel.AllEquip[typeInt] then
        table.insert(DataModel.AllEquip[typeInt], row)
      else
        DataModel.AllEquip[typeInt] = {}
        DataModel.AllEquip[typeInt][1] = row
      end
    end
  end
end

function DataModel:RefreshAllRoleData()
  DataModel.AllEquip = {}
  local list = PlayerData:GetEquips()
  if table.count(list) > 0 then
    for k, v in pairs(list) do
      local equipCA = PlayerData:GetFactoryData(v.id)
      local eid = k
      local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
      local row = {}
      row.eid = eid
      row.equipCA = equipCA
      row.tagCA = tagCA
      row.server = v
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
      if DataModel.AllEquip[typeInt] then
        table.insert(DataModel.AllEquip[typeInt], row)
      else
        DataModel.AllEquip[typeInt] = {}
        DataModel.AllEquip[typeInt][1] = row
      end
    end
  end
end

function DataModel:Load(self, skinId, isSkin)
  local portraitId = DataModel.RoleSeverData.current_skin[1]
  if skinId then
    portraitId = skinId
  end
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  View.Group_Middle.SpineAnimation_Character:SetActive(false)
  View.Group_Middle.SpineSecondMode_Character:SetActive(false)
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  DataModel.live2D = live2D
  local isSpine2 = false
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    View.Group_Middle.Group_Character.self:SetActive(false)
    View.Group_Middle.SpineAnimation_Character:SetActive(true)
    local spineUrl = portrailData.spineUrl
    local state = false
    if DataModel.RoleSeverData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" and DataModel.RoleSeverData.current_skin[2] == 1 then
      state = true
    end
    if isSkin ~= nil then
      state = isSkin
    end
    if state == true then
      spineUrl = portrailData.spine2Url
      isSpine2 = true
    end
    View.Group_Middle.SpineAnimation_Character:SetActive(not isSpine2)
    View.Group_Middle.SpineSecondMode_Character:SetActive(isSpine2)
    View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
    if live2D == 1 then
      View.Group_Middle.SpineAnimation_Character:SetActive(false)
      View.Group_Middle.SpineSecondMode_Character:SetActive(false)
      View.Group_Middle.Group_Character.self:SetActive(true)
      if isSpine2 == true then
        View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.State2Res)
      else
        View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
      end
      View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
      DataModel.InfoInitPos.isRecord = true
      if DataModel.InfoInitPos.isRecord then
        DataModel.InfoInitPos.isRecord = false
        local transform = View.Group_Middle.transform
        View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
        DataModel.InfoInitPos.y = transform.localPosition.y
        DataModel.InfoInitPos.scale = transform.localScale.x
      end
      DataModel.InfoInitPos.offsetX = portrailData.offsetX
      DataModel.InfoInitPos.offsetY = portrailData.offsetY
    elseif isSpine2 then
      View.Group_Middle.SpineSecondMode_Character:SetPrefab(spineUrl)
      View.Group_Middle.SpineAnimation_Character:SetData("")
      View.Group_Middle.SpineSecondMode_Character.transform.localPosition = Vector3(0, 0, 0)
      if portrailData.state2Overturn == true then
        View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
      end
    else
      View.Group_Middle.SpineAnimation_Character:SetActive(true)
      View.Group_Middle.SpineSecondMode_Character:SetPrefab("")
      View.Group_Middle.SpineAnimation_Character:SetData(spineUrl)
      View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
      View.Group_Middle.SpineAnimation_Character.transform.localPosition = Vector3(0, -1200 + portrailData.spineY, 0)
    end
  else
    View.Group_Middle.SpineAnimation_Character:SetActive(false)
    View.Group_Middle.Group_Character.self:SetActive(true)
    View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
    View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
    if DataModel.InfoInitPos.isRecord then
      DataModel.InfoInitPos.isRecord = false
      local transform = View.Group_Middle.transform
      View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
      DataModel.InfoInitPos.y = transform.localPosition.y
      DataModel.InfoInitPos.scale = transform.localScale.x
    end
    DataModel.InfoInitPos.offsetX = portrailData.offsetX
    DataModel.InfoInitPos.offsetY = portrailData.offsetY
  end
  View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(1, 1, 1))
  if DataModel.InfoInitPos.isRecord == false and isSpine2 == false then
    local portrailData = PlayerData:GetFactoryData(DataModel.RoleSeverData.current_skin[1], "UnitViewFactory")
    local pos = DataModel.InfoInitPos
    local posX = pos.x + portrailData.offsetX * pos.scale
    local posY = pos.y + portrailData.offsetY * pos.scale
    View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(0, portrailData.offsetY, 0))
    if isSpine2 == true then
      posX = pos.x + portrailData.spine2X * pos.scale
      posY = pos.y + portrailData.spine2Y * pos.scale
      View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(0, 0, 0))
    end
    View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(portrailData.offsetScale, portrailData.offsetScale, portrailData.offsetScale))
  end
  DataModel.NowSkin = {}
  DataModel.NowSkin.portraitId = tonumber(portraitId)
  DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
end

function DataModel:RefreshCenterNoEquipRoleView()
  local propertyList = PlayerData:GetRoleEquipProperty()
  local Group_Center = View.Group_Center
  Group_Center.Img_Hp:SetSprite(propertyList.healthPoint_SN.icon)
  Group_Center.Img_Hp.Txt_Hp:SetText(propertyList.healthPoint_SN.num)
  Group_Center.Img_Atk:SetSprite(propertyList.attack_SN.icon)
  Group_Center.Img_Atk.Txt_Atk:SetText(propertyList.attack_SN.num)
  Group_Center.Img_Def:SetSprite(propertyList.defence_SN.icon)
  Group_Center.Img_Def.Txt_Def:SetText(propertyList.defence_SN.num)
  Group_Center.Txt_Name:SetText(DataModel.RoleCA.name)
  Group_Center.Txt_EnglishName:SetText("")
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Using:SetActive(false)
end

function DataModel:RefreshCenterRoleView()
  local propertyList = {}
  local count = 0
  for k, v in pairs(DataModel.RoleSeverData.equips) do
    if v ~= "" then
      count = count + 1
      local list = {}
      local equip = PlayerData:GetEquipById(v)
      local equipCA = PlayerData:GetFactoryData(equip.id)
      list = PlayerData:GetRoleEquipProperty(equipCA, equip.lv)
      for c, d in pairs(list) do
        if propertyList[c] == nil then
          local row = {}
          row.type = d.type
          row.index = d.index
          row.num = d.num
          row.icon = d.icon
          propertyList[c] = row
        else
          propertyList[c].num = propertyList[c].num + d.num
        end
      end
    end
  end
  if count == 0 then
    propertyList = PlayerData:GetRoleEquipProperty()
  end
  local Group_Center = View.Group_Center
  Group_Center.Img_Hp:SetSprite(propertyList.healthPoint_SN.icon)
  Group_Center.Img_Hp.Txt_Hp:SetText(propertyList.healthPoint_SN.num)
  Group_Center.Img_Atk:SetSprite(propertyList.attack_SN.icon)
  Group_Center.Img_Atk.Txt_Atk:SetText(propertyList.attack_SN.num)
  Group_Center.Img_Def:SetSprite(propertyList.defence_SN.icon)
  Group_Center.Img_Def.Txt_Def:SetText(propertyList.defence_SN.num)
  Group_Center.Txt_Name:SetText(DataModel.RoleCA.name)
  Group_Center.Txt_EnglishName:SetText("")
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Using:SetActive(false)
  if DataModel.NowChooseEquip.server.hid == DataModel.RoleId then
    Group_Center.Btn_Compare.Img_Using:SetActive(true)
  else
    local now_equip = DataModel.RoleSeverData.equips[DataModel.LeftTopTagIndex]
    if now_equip ~= "" then
      if Group_Center.Group_Compare.self.IsActive == false then
        Group_Center.Btn_Compare.Img_Close:SetActive(true)
      else
        Group_Center.Btn_Compare.Img_Open:SetActive(true)
      end
    end
  end
end

function DataModel:RefreshRightDownContent(Group, index)
  local max = PlayerData:GetFactoryData(99900027)[DataModel.EntryMaxNum[DataModel.LeftTopTagIndex]]
  if index == 1 then
    local ScrollView_Content = Group.ScrollView_Content
    ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.NowChooseEquip.server.random_affix), max))
    SetDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.NowChooseEquip.server.random_affix, 1)
  else
    local eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
    local now_equip = PlayerData:GetEquipById(eid)
    Group.ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(now_equip.random_affix), max))
    SetDownAllAffix(Group.ScrollView_Content.Viewport.Content, now_equip.random_affix, index)
  end
end

function DataModel.ChooseLeftTop(index)
  if index == DataModel.LeftTopTagIndex then
    return
  end
  DataModel:Clear_Center()
  DataModel.NowList = {}
  DataModel.ShowNowList = {}
  DataModel.RoleEquipIndex = index
  DataModel.OldEquipData = {}
  local tagID = DataModel.RoleCA.equipmentSlotList[tonumber(index)].tagID
  local typeInt = PlayerData:GetFactoryData(tagID).typeID
  DataModel.RoleEquipType = typeInt
  local tagType = DataModel.LeftTopTag[index]
  if type(tagType) == "table" then
    for k, v in pairs(tagType) do
      if DataModel.AllEquip[v] then
        for c, d in pairs(DataModel.AllEquip[v]) do
          local row = d
          if v == DataModel.RoleEquipType then
            row.index = 1
            if row.server.hid ~= "" and row.server.hid == DataModel.RoleId then
              row.index = 0
            end
          else
            row.index = 2
          end
          table.insert(DataModel.NowList, row)
        end
      end
    end
  elseif DataModel.AllEquip[tagType] then
    for c, d in pairs(DataModel.AllEquip[tagType]) do
      local row = d
      if tagType == DataModel.RoleEquipType then
        row.index = 1
        if row.server.hid ~= "" and row.server.hid == DataModel.RoleId then
          row.index = 0
        end
      else
        row.index = 2
      end
      table.insert(DataModel.NowList, row)
    end
  end
  table.sort(DataModel.NowList, function(a, b)
    if a.index == b.index then
      if a.equipCA.qualityInt == b.equipCA.qualityInt then
        if a.server.lv == b.server.lv then
          return a.equipCA.id < b.equipCA.id
        end
        return a.server.lv > b.server.lv
      end
      return a.equipCA.qualityInt > b.equipCA.qualityInt
    end
    return a.index < b.index
  end)
  DataModel.LeftTopTagIndex = index
  DataModel.MySelfEquip = {}
  DataModel.MySelfEquip.eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
  DataModel.MySelfEquip.equipCA = PlayerData:GetEquipById(DataModel.MySelfEquip.eid) ~= nil and PlayerData:GetFactoryData(PlayerData:GetEquipById(DataModel.MySelfEquip.eid).id) or {}
  DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
  DataModel.MySelfEquip.old_locked = DataModel.MySelfEquip.server and DataModel.MySelfEquip.server.is_locked or 0
  DataModel.SendLockList = {}
  DataModel.SortDown = true
  DataModel.EquipIndex = nil
  if View.Group_Center.Group_Compare.self.IsActive == true then
    DataModel:OpenEquipCompare(true)
  end
  View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
  View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
  View.Group_Left.StaticGrid_Item.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.NowList))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  DataModel:ChooseEquip(1)
end

function DataModel.RefreshRightContent(Group, index)
  local List = {}
  if index == 1 then
    List = DataModel.NowChooseEquip
    Clear()
    if View.Group_Center.Group_Compare.self.IsActive == true and DataModel.NowChooseEquip.server.hid == DataModel.RoleId then
      local Group_Right = View.Group_Right
      Group_Right.self:SetActive(false)
      return
    end
  else
    List = DataModel.MySelfEquip
  end
  DataModel:RefreshCenterRoleView()
  local Group_Right = Group
  Group_Right.self:SetActive(true)
  Group_Right.Img_Quailty:SetSprite(UIConfig.WeaponQuality[List.equipCA.qualityInt + 1])
  Group_Right.Img_Quailty:SetNativeSize()
  Group_Right.Group_NameLevel.Txt_EquipmentName:SetText(List.equipCA.name)
  Group_Right.Group_NameLevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), List.server.lv))
  if List.server.hid == "" then
    Group_Right.Txt_EquipmentCharacter:SetActive(false)
  else
    Group_Right.Txt_EquipmentCharacter:SetActive(true)
    local name = PlayerData:GetFactoryData(List.server.hid).name
    Group_Right.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
  end
  Group_Right.Btn_Lock.Img_Lock:SetActive(false)
  Group_Right.Btn_Lock.Img_Unlock:SetActive(false)
  if DataModel.SendLockList[List.eid] == nil then
    local row = {}
    row.is_locked = List.server.is_locked
    row.isChange = 0
    row.old_locked = List.server.is_locked
    DataModel.SendLockList[List.eid] = row
  end
  if DataModel.SendLockList[List.eid].is_locked == 1 then
    Group_Right.Btn_Lock.Img_Lock:SetActive(true)
  else
    Group_Right.Btn_Lock.Img_Unlock:SetActive(true)
  end
  Group_Right.Img_Property.self:SetActive(false)
  local propertyList = PlayerData:GetRoleEquipProperty(List.equipCA, List.server.lv)
  Group_Right.Img_Property.self:SetActive(false)
  local pro = {}
  for k, v in pairs(propertyList) do
    if v.num ~= 0 then
      pro = v
    end
  end
  Group_Right.Img_Property:SetSprite(pro.icon)
  Group_Right.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(pro.num, 0) .. "</color>")
  Group_Right.Img_Property.self:SetActive(true)
  if index == 1 then
    Group_Right.Btn_Use:SetActive(false)
    Group_Right.Btn_Removing:SetActive(false)
    local now_equip = DataModel.RoleSeverData.equips[DataModel.LeftTopTagIndex]
    DataModel.SendRoleID = nil
    DataModel.SendRoleIsSelf = false
    if List.server.hid == DataModel.RoleId then
      DataModel.SendRoleID = DataModel.RoleId
      DataModel.SendRoleIsSelf = true
      if now_equip == "" or now_equip == nil then
        Group_Right.Btn_Use:SetActive(true)
      else
        Group_Right.Btn_Removing:SetActive(true)
      end
    else
      if List.server.hid == "" then
        DataModel.SendRoleIsSelf = true
      else
        DataModel.SendRoleIsSelf = false
      end
      DataModel.SendRoleID = List.server.hid
      Group_Right.Btn_Use:SetActive(true)
    end
  end
  DataModel:RefreshRightDownContent(Group, index)
  if DataModel.isPresets == true then
    View.Group_Right.Btn_Use:SetActive(false)
    View.Group_Right.Btn_Removing:SetActive(false)
    View.Group_Right.Btn_Strengthen.self:SetActive(false)
  else
    View.Group_Right.Btn_Strengthen.self:SetActive(true)
  end
end

function DataModel:OpenEquipCompare(state, callback)
  local Group_Center = View.Group_Center
  if Group_Center.Btn_Compare.Img_Using.self.IsActive == true then
    return
  end
  if DataModel.MySelfEquip.eid == "" and state == nil then
    return
  end
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  if Group_Center.Group_Compare.self.IsActive == false then
    Group_Center.Btn_Compare.Img_Open:SetActive(true)
    DataModel:Clear_Center()
    Group_Center.Group_Compare.self:SetActive(true)
    DataModel.RefreshRightContent(View.Group_Center.Group_Compare, 2)
    View.self:PlayAnim("In_Compare")
  else
    local callback = function()
      View.self:PlayAnim("Out_Compare", function()
        if DataModel.MySelfEquip.eid ~= "" then
          Group_Center.Btn_Compare.Img_Close:SetActive(true)
        end
        Group_Center.Group_Compare.self:SetActive(false)
        if View.Group_Right.self.IsActive == false then
          local index = DataModel.EquipIndex
          DataModel.EquipIndex = nil
          DataModel:ChooseEquip(index)
        end
        if callback then
          callback()
        end
      end)
    end
    DataModel:SendMyselfEquipLockData(callback)
  end
end

function DataModel:ChooseEquip(index)
  if index == DataModel.EquipIndex then
    return
  end
  DataModel.NowChooseEquip = {}
  local Group_Right = View.Group_Right
  if index and DataModel.ShowNowList[index] then
    if DataModel.EquipIndex then
      DataModel.ShowNowList[DataModel.EquipIndex].element.Group_Equipment.Img_Select:SetActive(false)
    end
    DataModel.EquipIndex = index
    DataModel.NowChooseEquip = DataModel.NowList[index]
    DataModel.ShowNowList[index].element.Group_Equipment.Img_Select:SetActive(true)
    DataModel.RefreshRightContent(View.Group_Right, 1)
  else
    Group_Right.self:SetActive(false)
    DataModel:RefreshCenterNoEquipRoleView()
    return
  end
end

function DataModel:ChoosePresetEquip(index)
  DataModel.NowChooseEquip = {}
  if index == DataModel.EquipIndex then
    return
  end
  if index and DataModel.NowPresetList[index] then
    DataModel.EquipIndex = index
    DataModel.NowChooseEquip = DataModel.NowPresetList[index]
    DataModel.RefreshRightContent(View.Group_Right, 1)
  else
    local Group_Right = View.Group_Right
    Group_Right.self:SetActive(false)
    return
  end
end

function DataModel:SendEquipLockData(callback)
  local isChange = false
  local str_lock = ""
  local str_unlock = ""
  local changeList = {}
  if table.count(DataModel.SendLockList) > 0 then
    for k, v in pairs(DataModel.SendLockList) do
      if v.isChange == 1 then
        if v.is_locked == 1 then
          str_lock = str_lock .. k .. ";"
        else
          str_unlock = str_unlock .. k .. ";"
        end
        isChange = true
        table.insert(changeList, {
          eid = k,
          is_locked = v.is_locked
        })
      end
    end
    str_lock = string.sub(str_lock, 1, string.len(str_lock) - 1)
    str_unlock = string.sub(str_unlock, 1, string.len(str_unlock) - 1)
  else
    isChange = false
  end
  if isChange == false then
    if callback then
      callback()
    end
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipById(v.eid).is_locked = v.is_locked
      end
      if callback then
        callback()
      end
    end, str_lock, str_unlock)
  end
end

function DataModel:SendMyselfEquipLockData(callback)
  local isChange = false
  local str_lock = ""
  local str_unlock = ""
  local changeList = {}
  if DataModel.MySelfEquip.isChange and DataModel.MySelfEquip.isChange == 1 then
    if DataModel.MySelfEquip.server.is_locked == 1 then
      str_lock = str_lock .. DataModel.MySelfEquip.eid .. ";"
    else
      str_unlock = str_unlock .. DataModel.MySelfEquip.eid .. ";"
    end
    isChange = true
    table.insert(changeList, {
      eid = DataModel.MySelfEquip.eid,
      is_locked = DataModel.MySelfEquip.server.is_locked
    })
  end
  str_lock = string.sub(str_lock, 1, string.len(str_lock) - 1)
  str_unlock = string.sub(str_unlock, 1, string.len(str_unlock) - 1)
  if isChange == false then
    callback()
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipById(v.eid).is_locked = v.is_locked
      end
      DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
      DataModel.MySelfEquip.isChange = 0
      callback()
    end, str_lock, str_unlock)
  end
end

function DataModel:SortButton()
  DataModel.SortDown = not DataModel.SortDown
  if table.count(DataModel.NowList) == 0 then
    return
  end
  if DataModel.SortDown == true then
    View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
    table.sort(DataModel.NowList, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.server.lv == b.server.lv then
            return a.equipCA.id < b.equipCA.id
          end
          return a.server.lv > b.server.lv
        end
        return a.equipCA.qualityInt > b.equipCA.qualityInt
      end
      return a.index < b.index
    end)
  else
    View.Group_Left.Btn_Sort.Img_Down:SetActive(false)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(true)
    table.sort(DataModel.NowList, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.server.lv == b.server.lv then
            return a.equipCA.id > b.equipCA.id
          end
          return a.server.lv < b.server.lv
        end
        return a.equipCA.qualityInt < b.equipCA.qualityInt
      end
      return a.index > b.index
    end)
  end
  DataModel.EquipIndex = nil
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.NowList))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  DataModel:ChooseEquip(1)
end

function DataModel:OpenPresets(index)
  DataModel.PresetList = {}
  DataModel.isPresets = true
  View.Group_Left.self:SetActive(false)
  View.Group_Left_Presets.self:SetActive(true)
  View.Group_Detail.self:SetActive(true)
  DataModel:ClickDetail()
  View.Group_Center.Btn_Detail.self:SetActive(false)
  View.Group_Center.Btn_Presets.self:SetActive(false)
  View.Group_Center.Btn_Compare.self:SetActive(false)
  View.Group_Right.Btn_Use:SetActive(false)
  View.Group_Right.Btn_Removing:SetActive(false)
  View.Group_Right.Btn_Strengthen.self:SetActive(false)
  DataModel.SendLockList = {}
  DataModel.PresetIndex = index or nil
  DataModel.PresetListElement = {}
  DataModel.PresetListElementData = {}
  table.insert(DataModel.PresetListElementData, DataModel.RoleSeverData.equips)
  for k, v in pairs(DataModel.RoleSeverData.pre_equips) do
    local row = {}
    for c, d in pairs(v) do
      local t_v = d
      if d ~= "" and PlayerData:GetEquipById(d) == nil then
        t_v = ""
      end
      table.insert(row, t_v)
    end
    table.insert(DataModel.PresetListElementData, row)
  end
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:SetDataCount(table.count(DataModel.PresetListElementData))
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:RefreshAllElement()
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:MoveToTop()
  local Group_Right = View.Group_Right
  Group_Right.self:SetActive(false)
  DataModel:ChoosePresetsGroup(DataModel.PresetIndex or 1)
  View.self:PlayAnim("In_Presets")
end

function DataModel:ClosePresets(state, init)
  DataModel.isPresets = false
  View.Group_Left.self:SetActive(true)
  View.Group_Left_Presets.self:SetActive(false)
  View.Group_Center.Btn_Detail.self:SetActive(false)
  View.Group_Center.Btn_Presets.self:SetActive(true)
  View.Group_Center.Btn_Compare.self:SetActive(true)
  if state then
    local index = DataModel.LeftTopTagIndex
    DataModel.LeftTopTagIndex = nil
    DataModel.ChooseLeftTop(index)
  end
  if not init then
    View.self:PlayAnim("Out_Presets")
  end
end

function DataModel:SetEquipElement(element, elementIndex, index)
  local eid = DataModel.PresetListElementData[elementIndex][index]
  local Group_Equipment = element["Group_Equipment_" .. index]
  local Group_Info = Group_Equipment.Group_Info
  Group_Equipment.Img_Defect:SetActive(false)
  Group_Equipment.Img_NoType:SetActive(false)
  Group_Info:SetActive(false)
  local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(index)].tagID)
  if eid ~= "" and PlayerData:GetEquipById(eid) then
    local equipSever = PlayerData:GetEquipById(eid)
    Group_Info:SetActive(true)
    local equipCA = PlayerData:GetFactoryData(equipSever.id)
    Group_Info.Btn_Item:SetClickParam(elementIndex)
    Group_Info.Img_Item:SetSprite(equipCA.iconPath)
    Group_Info.Img_Mask:SetSprite(UIConfig.MaskConfig[equipCA.qualityInt + 1])
    Group_Info.Img_Bottom:SetSprite(UIConfig.BottomConfig[equipCA.qualityInt + 1])
    Group_Info.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), equipSever.lv))
    Group_Info.Img_Select:SetActive(false)
    Group_Info.Img_Character:SetActive(false)
    if equipSever.hid ~= "" then
      Group_Info.Img_Character:SetActive(true)
      Group_Info.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(equipSever.hid).viewId).face)
    end
    Group_Info.Img_Lock:SetActive(false)
    if equipSever.is_locked == 1 then
      Group_Info.Img_Lock:SetActive(true)
    end
    local equipType = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
    if typeInt ~= equipType then
      Group_Info.Img_NoType:SetActive(true)
    end
  elseif typeInt ~= 0 then
    Group_Equipment.Img_Waepon:SetActive(true)
    Group_Equipment.Img_Waepon:SetSprite(DataModel.EquipTypeIcon[typeInt])
  else
    Group_Equipment.Img_Waepon:SetActive(false)
  end
end

function DataModel:ChoosePresetsGroup(str)
  if DataModel.PresetIndex and tonumber(str) == DataModel.PresetIndex then
    return
  end
  if DataModel.PresetIndex ~= nil then
    DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets.Img_Select:SetActive(false)
    DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
    DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
    DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
  end
  DataModel.PresetIndex = tonumber(str)
  DataModel.PresetListElement[DataModel.PresetIndex].Btn_Presets.Img_Select:SetActive(true)
  local count = 0
  DataModel.NowPresetList = {}
  for k, v in pairs(DataModel.PresetListElementData[tonumber(str)]) do
    local severEquip = PlayerData:GetEquipById(v)
    local equipCA = {}
    if severEquip then
      equipCA = PlayerData:GetFactoryData(severEquip.id)
      count = count + 1
    end
    local eid = v
    local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
    local row = {}
    row.eid = eid
    row.equipCA = equipCA
    row.tagCA = tagCA
    row.server = severEquip
    table.insert(DataModel.NowPresetList, row)
  end
  local eid = DataModel.NowPresetList[1].eid
  if eid ~= "" and DataModel.NowPresetList[1].server then
    DataModel.EquipIndex = nil
    DataModel:ChoosePresetEquip(1)
    DataModel.PresetListElement[tonumber(str)].Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(true)
  else
    local Group_Right = View.Group_Right
    Group_Right.self:SetActive(false)
  end
  local Group_Left_Presets = View.Group_Left_Presets
  Group_Left_Presets.Btn_Save.Img_Close:SetActive(true)
  Group_Left_Presets.Btn_Delete.Img_Close:SetActive(true)
  if DataModel.PresetIndex == 1 then
    Group_Left_Presets.Btn_Save.Img_Open:SetActive(false)
    Group_Left_Presets.Btn_Delete.Img_Open:SetActive(false)
  else
    Group_Left_Presets.Btn_Save.Img_Open:SetActive(true)
    if count ~= 0 then
      Group_Left_Presets.Btn_Delete.Img_Open:SetActive(true)
    else
      Group_Left_Presets.Btn_Delete.Img_Open:SetActive(false)
    end
  end
  if View.Group_Detail.self.IsActive == true then
    DataModel:OpenDetail()
  end
end

function DataModel:UsePresets(index)
  local choose_equip = DataModel.PresetListElementData[DataModel.PresetIndex]
  local now_equip = DataModel.PresetListElementData[1]
  local num, row = table:Difference(choose_equip, now_equip)
  local new_equip = {}
  if 0 < num then
    local notmyselfCount = 0
    local notequipCount = 0
    for k, v in pairs(choose_equip) do
      new_equip[k] = v
      if v ~= "" then
        local equip = PlayerData:GetEquipById(v)
        if equip == nil then
          notequipCount = notequipCount + 1
          new_equip[k] = ""
        end
        if equip.hid ~= "" and equip.hid ~= DataModel.RoleId then
          notmyselfCount = notmyselfCount + 1
        end
      end
    end
    local callback = function()
      Net:SendProto("hero.load", function(json)
        print_r(json)
        for k, v in pairs(new_equip) do
          local equip = PlayerData:GetEquipById(v)
          if equip ~= nil then
            if equip.hid ~= "" then
              PlayerData:GetRoleById(tonumber(equip.hid)).equips[k] = ""
            end
            equip.hid = DataModel.RoleId
          elseif now_equip[k] ~= "" then
            PlayerData:GetEquipById(now_equip[k]).hid = ""
          end
        end
        PlayerData:GetRoleById(DataModel.RoleId).equips = new_equip
        DataModel:RefreshChooseRoleEquip(new_equip)
        DataModel.PresetListElementData[1] = new_equip
        DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
        View.Group_Left_Presets.ScrollGrid_Presets.grid.self:SetDataCount(table.count(DataModel.RoleSeverData.pre_equips) + 1)
        View.Group_Left_Presets.ScrollGrid_Presets.grid.self:RefreshAllElement()
      end, DataModel.RoleId, DataModel.PresetIndex - 2)
    end
    if 0 < notmyselfCount then
      CommonTips.OnPrompt(80600472, nil, nil, callback)
      return
    end
    if 0 < notequipCount then
      CommonTips.OnPrompt(80600473, nil, nil, callback)
      return
    end
    local count = 0
    for k, v in pairs(now_equip) do
      if v ~= "" then
        count = count + 1
      end
    end
    if count == 0 then
      callback()
    else
      CommonTips.OnPrompt(80600532, nil, nil, callback)
    end
  end
end

local baseDetailDesHight = 26
local SetDetailAffix = function(obj, row)
  obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  local hight_des = obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  if 24 < hight_des then
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, -hight_des + 35)
  else
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, -2)
  end
  local Hight = 0
  if hight_des > baseDetailDesHight then
    Hight = hight_des - baseDetailDesHight
  end
  return Hight
end

function DataModel:SetDetailAllAffix(AffixList)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = -10
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 794
  local space = 0
  View.Group_Detail.Group_Detail.ScrollView_Content.self:SetLocalPositionY(-112)
  space = top_des_height
  DataModel.AffixList_Detail = {}
  local random_affix = AffixList or {}
  if 0 < table.count(random_affix) then
    for i = 1, table.count(random_affix) do
      local talentCA = PlayerData:GetFactoryData(random_affix[i].id)
      if random_affix[i].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(random_affix[i].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local Group_Entry_Detail = "UI/CharacterInfo/weapon/Group_Entry_Weapon_Detail"
      local Parent = View.Group_Detail.Group_Detail.ScrollView_Content.Viewport.Content.transform
      local obj = View.self:GetRes(Group_Entry_Detail, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 55
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList_Detail, obj)
      local hight_des = SetDetailAffix(obj, talentCA)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Detail.Group_Detail.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:OpenDetail()
  local Group_Addition = View.Group_Detail.Group_Detail.Group_Addition
  local propertyList = {}
  local affixList = {}
  local count = 0
  for k, v in pairs(DataModel.NowPresetList) do
    if v.server then
      count = count + 1
      local list = {}
      list = PlayerData:GetRoleEquipProperty(v.equipCA, v.server.lv)
      for c, d in pairs(list) do
        if propertyList[c] == nil then
          local row = {}
          row.type = d.type
          row.index = d.index
          row.num = d.num
          row.icon = d.icon
          propertyList[c] = row
        else
          propertyList[c].num = propertyList[c].num + d.num
        end
      end
      if 0 < table.count(v.server.random_affix) then
        for n, m in pairs(v.server.random_affix) do
          table.insert(affixList, m)
        end
      end
    end
  end
  DataModel:Clear_Detail()
  Group_Addition.Img_Hp:SetSprite(UIConfig.AttributeType.CurrentHp.icon)
  Group_Addition.Img_Atk:SetSprite(UIConfig.AttributeType.Atk.icon)
  Group_Addition.Img_Def:SetSprite(UIConfig.AttributeType.Def.icon)
  Group_Addition.Img_Hp.Txt_Hp:SetText("生命值       " .. 0)
  Group_Addition.Img_Atk.Txt_Atk:SetText("攻击力       " .. 0)
  Group_Addition.Img_Def.Txt_Def:SetText("防御力       " .. 0)
  if count ~= 0 then
    Group_Addition.Img_Hp.Txt_Hp:SetText("生命值       " .. propertyList.healthPoint_SN.num)
    Group_Addition.Img_Atk.Txt_Atk:SetText("攻击力       " .. propertyList.attack_SN.num)
    Group_Addition.Img_Def.Txt_Def:SetText("防御力       " .. propertyList.defence_SN.num)
  end
  DataModel:SetDetailAllAffix(affixList)
end

function DataModel:ClickDetail()
  if View.Group_Detail.self.IsActive == true then
    View.Group_Detail.self:SetActive(false)
    View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(true)
    View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(false)
  else
    View.Group_Detail.self:SetActive(true)
    DataModel:OpenDetail()
    View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(false)
    View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(true)
  end
end

return DataModel
