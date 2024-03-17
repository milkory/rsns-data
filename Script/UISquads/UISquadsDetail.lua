local View = require("UISquads/UISquadsView")
local DataModel = require("UISquads/UISquadsDataModel")
local Detail = {}
Detail.Now_Element = nil
Detail.Last_Index = nil

function Detail:DetectionData()
  local count = 0
  for k, v in pairs(DataModel.Role_Skills) do
    local aa = table:Difference(DataModel.RoleData.skill_list[k], v)
    count = count + aa
  end
  for k, v in pairs(DataModel.Role_Equips) do
    local bb = table:Difference(DataModel.RoleData.equips[k], v)
    count = count + bb
  end
  local dd = table:Difference(DataModel.Card, DataModel.RoleData.Squads.skill_list)
  count = count + dd
  if 0 < count then
    return true
  end
  return false
end

function Detail:ClearDetail()
  Detail.Now_Element = nil
  Detail.Last_Index = nil
end

function Detail:UpdateCardSkillList()
  local count = 0
  local connect = ","
  local string_value = ""
  local skill_list = {}
  for i = 1, table.count(DataModel.Skill_Temp) do
    local row = DataModel.RoleData.skills[i]
    string_value = string_value .. row.num .. connect
    skill_list[i] = row.num
    if DataModel.Skill_Temp[i] ~= row.num then
      count = count + 1
    end
  end
  string_value = string.sub(string_value, 1, string.len(string_value) - 1)
  if count ~= 0 then
    Net:SendProto("card.update", function(res)
      PlayerData:GetRoleById(DataModel.RoleData.id).skill_list = skill_list
    end, DataModel.RoleData.id, string_value)
  end
end

function Detail:SetDetailPos(btn, index)
  View.Group_Detail.self.transform.position = btn.transform.position
  local isTopThree = false
  local integer, floor = math.modf(index / 6)
  local limt
  if floor == 0 then
    limt = integer * 6 - 3
  else
    limt = (integer + 1) * 6 - 3
  end
  if index > limt then
    isTopThree = false
  else
    isTopThree = true
  end
  if isTopThree == true then
    local pos_x = View.Group_Detail.self.transform.localPosition.x + 570
    local pos_y = View.Group_Detail.self.transform.localPosition.y + 160
    if 0 < pos_y and pos_y + 337 > 540 then
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, 203, 0))
    elseif pos_y < 0 and pos_y - 337 < -540 then
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, -203, 0))
    else
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, pos_y, 0))
    end
  end
  if isTopThree == false then
    local pos_x = View.Group_Detail.self.transform.localPosition.x - 570
    local pos_y = View.Group_Detail.self.transform.localPosition.y + 140
    if 0 < pos_y and pos_y + 337 > 540 then
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, 203, 0))
    elseif pos_y < 0 and pos_y - 337 < -540 then
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, -203, 0))
    else
      View.Group_Detail.self:SetLocalPosition(Vector3(pos_x, pos_y, 0))
    end
  end
end

function Detail:RefreshDetail()
  local temp_attribute = View.Group_Detail.Group_Property.Btn_Attribute
  temp_attribute.Img_Health.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[2].num, 0)))
  temp_attribute.Img_Attack.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[1].num, 0)))
  temp_attribute.Img_Defense.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[3].num, 0)))
  temp_attribute.Img_AtkRange.Txt_Value:SetText(DataModel.AttributeData[7].num)
  View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
end

function Detail:RefreshSelectDetail()
  local temp_attribute = View.Group_CharacterSelect.Group_Detail.Group_Property.Btn_Attribute
  temp_attribute.Img_Health.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[2].num, 0)))
  temp_attribute.Img_Attack.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[1].num, 0)))
  temp_attribute.Img_Defense.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.AttributeData[3].num, 0)))
  temp_attribute.Img_Cri.Txt_Value:SetText((PlayerData:GetAttributeShow(DataModel.AttributeData[4].name, DataModel.AttributeData[4].num, 2)))
  temp_attribute.Img_CriDamage.Txt_Value:SetText((PlayerData:GetAttributeShow(DataModel.AttributeData[5].name, DataModel.AttributeData[5].num, 2)))
  temp_attribute.Img_AtkRange.Txt_Value:SetText(DataModel.AttributeData[7].num)
  temp_attribute.Img_Sp.Txt_Value:SetText(DataModel.RoleCA.spName ~= "" and DataModel.RoleCA.spName or "无")
  View.Group_CharacterSelect.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
end

local SwitchSpeed = function(tSpeed)
  if tSpeed <= 80 then
    return 80600232
  elseif tSpeed <= 120 then
    return 80600233
  elseif tSpeed <= 200 then
    return 80600234
  elseif tSpeed <= 275 then
    return 80600235
  else
    return 80600236
  end
end
local SwitchSpeedRange = function(line)
  local line_config = {
    [0] = 80600228,
    [1] = 80600229,
    [2] = 80600230,
    [3] = 80600231
  }
  return line_config[line] or line
end

function Detail:OpenRoleDetail(element, index, role)
  if Detail.Last_Index ~= nil and Detail.Last_Index == index and role == nil then
    return
  end
  UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_Detail")
  View.Group_Detail.self:SetActive(true)
  DataModel.LastRoleIndex = index
  DataModel.RoleData = PlayerData:GetRoleById(role.unitId)
  DataModel.RoleCA = PlayerData:GetFactoryData(role.unitId)
  local skills = {}
  local skillList = DataModel.RoleCA.skillList
  local row_skill = PlayerData:GetRoleSkill(role.unitId)
  local card_list = PlayerData.currentSquad[DataModel.curSelectIndex].skill_list
  DataModel.Skill_Temp = card_list
  local unitCA = PlayerData:GetFactoryData(DataModel.RoleData.id).skillList
  local skills_squad = DataModel.Squads[DataModel.curSquadIndex][index].skill_list
  for k1, v1 in pairs(skillList) do
    local factory = PlayerData:GetFactoryData(v1.skillId)
    local lv_t = 1
    if row_skill[k1] then
      lv_t = row_skill[k1].lv
    end
    skills[k1] = {
      lv = lv_t,
      path = factory.iconPath,
      name = factory.name,
      id = v1.skillId,
      num = card_list[k1] == "" and unitCA[k1].num or card_list[k1]
    }
    skills_squad[k1] = card_list[k1] == "" and unitCA[k1].num or card_list[k1]
  end
  DataModel.RoleData.skills = skills
  DataModel.AttributeData = {}
  local temp_data = {}
  temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tSummonFinalDamageUp = PlayerData:CountRoleAttributeById(role.unitId, role.skill1Lv, role.skill2Lv, role.skill3Lv, role.lv, role.awakeLv, role.resonanceLv, role.trust_lv or 1)
  for k, v in pairs(PlayerData.AttributeConfig) do
    local row = {}
    DataModel.AttributeData[k] = row
    row.name = v.txt
    if temp_data[v.type] then
      row.num = temp_data[v.type] + 1.0E-7 or 0
      row.num = PlayerData:GetPreciseDecimalFloor(row.num, 2)
      if v.type == "tSpeed" then
        row.num = GetText(SwitchSpeed(temp_data[v.type]))
      end
    else
      if v.type == "tSpeedRange" then
        row.num = GetText(SwitchSpeedRange(DataModel.RoleCA.line))
      end
      if v.type == "tSpName" then
        row.num = DataModel.RoleCA.specialGiftDes
      end
    end
    row.sprite = v.sprite
  end
  UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_Detail")
  View.Group_Detail.self:SetActive(true)
  View.Group_Detail.Img_Remind:SetActive(PlayerData:GetAllRoleAwakeRedID(role.unitId))
  View.Btn_Mask:SetActive(true)
  DataModel.RoleData.Squads = DataModel.Squads[DataModel.curSquadIndex][index]
  DataModel.Role_Skills = {}
  if DataModel.RoleData.skill_list ~= nil and 0 < table.count(DataModel.RoleData.skill_list) then
    for k, v in pairs(DataModel.RoleData.skill_list) do
      table.insert(DataModel.Role_Skills, v)
    end
  end
  DataModel.Role_Equips = {}
  for k, v in pairs(DataModel.RoleData.equips) do
    table.insert(DataModel.Role_Equips, v)
  end
  DataModel.Equip = {}
  DataModel.Card = {}
  for k, v in pairs(DataModel.RoleData.Squads.skill_list) do
    table.insert(DataModel.Card, v)
  end
  Detail.Now_Element = element
  Detail.Last_Index = index
  Detail.Now_Element.transform:SetAsLastSibling()
  Detail:RefreshDetail()
  View.Group_Detail.Btn_OutTeam.self:SetActive(false)
  View.Group_Detail.Btn_InTeam.self:SetActive(false)
  DataModel.InitData = {}
  DataModel.InitData = Clone(DataModel.RoleData)
  DOTweenTools.DOLocalMoveY(View.Group_Detail.transform, 0, 0.25)
end

function Detail:CloseChangeDetail()
  View.Group_Detail.self:SetActive(false)
  Detail:ClearDetail()
end

function Detail:CloseDetail()
  View.Group_Detail.self:SetActive(false)
  View.Btn_Mask:SetActive(false)
  Detail:ClearDetail()
end

function Detail:CloseChooseDetail()
  View.Group_CharacterSelect.ScrollGrid_CharacterList.self:SetEnable(true)
  View.Group_Detail.self:SetActive(false)
  Detail:ClearDetail()
end

function Detail:ShowLeftDetail(index, role)
  View.Group_CharacterSelect.Group_Detail.self:SetActive(true)
  if DataModel.curSelectIndex and DataModel.SortRoles[DataModel.curSelectIndex] then
    local element = DataModel.SortRoles[DataModel.curSelectIndex].element
    if element then
      element.Img_Selected:SetActive(false)
    end
  end
  DataModel.curSelectIndex = index
  DataModel.RoleData = PlayerData:GetRoleById(role.id)
  DataModel.RoleCA = PlayerData:GetFactoryData(role.id)
  DataModel.RoleData.skills = role.skills
  DataModel.AttributeData = {}
  local temp_data = {}
  temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tSummonFinalDamageUp = PlayerData:CountRoleAttributeById(role.id, role.skills[1].lv, role.skills[2].lv, role.skills[3].lv, role.lv, role.awake_lv, role.resonance_lv, role.trust_lv or 1)
  for k, v in pairs(PlayerData.AttributeConfig) do
    local row = {}
    DataModel.AttributeData[k] = row
    row.name = v.txt
    if temp_data[v.type] then
      row.num = temp_data[v.type] + 1.0E-7 or 0
      row.num = PlayerData:GetPreciseDecimalFloor(row.num, 2)
      if v.type == "tSpeed" then
        row.num = GetText(SwitchSpeed(temp_data[v.type]))
      end
    else
      if v.type == "tSpeedRange" then
        row.num = GetText(SwitchSpeedRange(DataModel.RoleCA.line))
      end
      if v.type == "tSpName" then
        row.num = DataModel.RoleCA.specialGiftDes
      end
    end
    row.sprite = v.sprite
  end
  if index and DataModel.SortRoles[index] then
    local element = DataModel.SortRoles[index].element
    if element then
      element.Img_Selected:SetActive(true)
    end
  end
  Detail:RefreshSelectDetail()
end

function Detail:RefreshBottomState(role)
  if role.squads_index == 0 then
    View.Group_CharacterSelect.Group_Detail.Btn_OutTeam.self:SetActive(false)
    View.Group_CharacterSelect.Group_Detail.Btn_InTeam.self:SetActive(true)
  else
    View.Group_CharacterSelect.Group_Detail.Btn_OutTeam.self:SetActive(true)
    View.Group_CharacterSelect.Group_Detail.Btn_InTeam.self:SetActive(false)
  end
end

return Detail
