local View = require("UIRoleDetail/UIRoleDetailView")
local DataModel = require("UIRoleDetail/UIRoleDetailDataModel")
local ViewFunction = require("UIRoleDetail/UIRoleDetailViewFunction")
local baseDesHight = 50
local baseBGHight = 140
local baseBGWidth = 1100
local offest_height = 5
local skillBg_base = 221
local SetLeftRoleDown = function(obj, row)
  obj.transform:Find("Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Txt_Num").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.num)
end
local SkillHightBase = 112
local SetRightRoleSkill = function(obj, row, index)
  local skillCA = PlayerData:GetFactoryData(row.id)
  obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
  if index ~= 1 then
    obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(false)
  end
  local costNum = PlayerData:GetFactoryData(skillCA.cardID).cost_SN or 0
  local num = DataModel.CA.skillList[index] and DataModel.CA.skillList[index].num or 1
  obj.transform:Find("Group_CellSkill/Group_Top/Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(skillCA.name)
  obj.transform:Find("Group_CellSkill/Img_CaptainSkill").transform:GetComponent(typeof(CS.Seven.UIImg)):SetActive(false)
  obj.transform:Find("Group_CellSkill/Txt_Des_Leader").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText("")
  local Hight = 28
  if skillCA.leaderCardConditionDesc ~= nil and skillCA.leaderCardConditionDesc ~= "" then
    local tagCA = PlayerData:GetFactoryData(80600356)
    if tagCA.text ~= "" then
      obj.transform:Find("Group_CellSkill/Img_CaptainSkill").transform:GetComponent(typeof(CS.Seven.UIImg)):SetActive(true)
      obj.transform:Find("Group_CellSkill/Txt_Des_Leader").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(tagCA.text .. skillCA.leaderCardConditionDesc)
      Hight = Hight - obj.transform:Find("Group_CellSkill/Txt_Des_Leader").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
    end
  end
  obj.transform:Find("Group_CellSkill/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):SetLocalPositionY(-3 + Hight)
  obj.transform:Find("Group_CellSkill/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.des)
  local SkillHight = 0
  local now_Skill_Hight = obj.transform:Find("Group_CellSkill/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  if now_Skill_Hight > SkillHightBase then
    SkillHight = now_Skill_Hight - SkillHightBase
  end
  obj.transform:Find("Group_CellSkill/Img_Bg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, skillBg_base)
  if 0 < Hight + SkillHight then
    obj.transform:Find("Group_CellSkill/Img_Bg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, skillBg_base + (Hight + SkillHight))
  end
  obj.transform:Find("Group_CellSkill/Img_Icon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(skillCA.iconPath)
  obj.transform:Find("Group_CellSkill/Group_Count/Text_Count").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(num)
  obj.transform:Find("Group_CellSkill/Group_Cost/Text_Cost").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(math.ceil(costNum))
  return Hight + SkillHight
end
local SetRightRoleTalent = function(obj, row, index)
  obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
  if index ~= 1 then
    obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(false)
  end
  obj.transform:Find("Group_CellR/Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Group_CellR/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.desc)
  local hight_des = obj.transform:Find("Group_CellR/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  obj.transform:Find("Group_CellR/Img_Bg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, baseBGHight)
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
    obj.transform:Find("Group_CellR/Img_Bg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, Hight + baseBGHight)
  end
  obj.transform:Find("Group_CellR/Txt_Stage").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(string.format(GetText(80600419), index))
  obj.transform:Find("Group_CellR/Img_Icon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.path)
  return Hight
end
local SetRightRoleBreak = function(obj, row, index)
  obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
  if index ~= 2 then
    obj.transform:Find("Txt_T").transform:GetComponent(typeof(CS.Seven.UITxt)):SetActive(false)
  end
  obj.transform:Find("Group_CellB/Txt_Name").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.name)
  obj.transform:Find("Group_CellB/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.desc)
  local hight_des = obj.transform:Find("Group_CellB/Txt_Des").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
    obj.transform:Find("Group_CellB/Img_Bg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetImgWidthAndHeight(baseBGWidth, Hight + baseBGHight)
  end
  obj.transform:Find("Group_CellB/Txt_Stage").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(string.format(GetText(80600418), index - 1))
  obj.transform:Find("Group_CellB/Img_Icon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.path)
  obj.transform:Find("Group_CellB/Img_IconBg").transform:GetComponent(typeof(CS.Seven.UIImg)):SetActive(false)
  return Hight
end
local baseDetailDesHight = 26
local SetDetailAffix = function(obj, row)
  obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  local hight_des = obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  if 24 < hight_des then
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, -hight_des + 40)
  else
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, 5)
  end
  local Hight = 0
  if hight_des > baseDetailDesHight then
    Hight = hight_des - baseDetailDesHight
  end
  return Hight
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
local RefreshLeftData = function()
  local upData = {
    [1] = {
      type = "tHp",
      txt = "生命值",
      sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_health"
    },
    [2] = {
      type = "tAtk",
      txt = "攻击力",
      sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_attack"
    },
    [3] = {
      type = "tDef",
      txt = "防御力",
      sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_defense"
    },
    [4] = {
      type = "tSpeed",
      txt = "攻撃速度",
      sprite = "UI\\Common\\Characterinfo_icon_att_attackSpd"
    },
    [5] = {
      type = "tSpeedRange",
      txt = "攻撃範囲",
      sprite = "UI\\Common\\Characterinfo_icon_att_attackRange"
    }
  }
  for i = 0, 4 do
    local obj = View.Group_Left.Group_Property.Img_Mask.ScrollView_Left.Viewport.Content.Group_CellBase["Group_CellBase_" .. i]
    local row = upData[i + 1]
    obj.Img_Icon:SetSprite(row.sprite)
    obj.Txt_Name:SetText(row.txt)
    if DataModel.AttributeData[row.type] then
      local num = DataModel.AttributeData[row.type] + 1.0E-7 or 0
      num = PlayerData:GetPreciseDecimalFloor(num, 2)
      if row.type == "tSpeed" then
        num = "100%"
      end
      obj.Txt_Num:SetText(num)
    else
      local num = 0
      if row.type == "tSpeedRange" then
        num = GetText(SwitchSpeedRange(DataModel.CA.line))
      end
      if row.type == "tSpName" then
        num = DataModel.CA.specialGiftDes
      end
      obj.Txt_Num:SetText(num)
    end
  end
  local leftDownList = {}
  for k, v in pairs(DataModel.CA.talentList) do
    local ca = PlayerData:GetFactoryData(v.talentId)
    if ca.attriDetialList and 0 < table.count(ca.attriDetialList) then
      for c, d in pairs(ca.attriDetialList) do
        local num = d.num
        local tagCA = PlayerData:GetFactoryData(d.tagId)
        local name = tagCA.tagName
        if leftDownList[name] == nil then
          leftDownList[name] = {}
          leftDownList[name].num = num
        else
          leftDownList[name].num = leftDownList[name].num + num
        end
      end
    end
  end
  for k, v in pairs(DataModel.CA.breakthroughList) do
    local ca = PlayerData:GetFactoryData(v.breakthroughId)
    if ca.attriDetialList and 0 < table.count(ca.attriDetialList) then
      for c, d in pairs(ca.attriDetialList) do
        local num = d.num
        local tagCA = PlayerData:GetFactoryData(d.tagId)
        local name = tagCA.tagName
        if leftDownList[name] == nil then
          leftDownList[name] = {}
          leftDownList[name].num = num
        else
          leftDownList[name].num = leftDownList[name].num + num
        end
      end
    end
  end
  local count = table.count(leftDownList)
  if 0 < count then
    local space = View.Group_Left.Group_Property.Img_Mask.ScrollView_Left.Viewport.Content.Group_CellExtra.Group_CellExtra.Rect.sizeDelta.y * (count - 1)
    View.Group_Left.Group_Property.Img_Mask.ScrollView_Left:SetContentHeight(350 + space)
    local parent = View.Group_Left.Group_Property.Img_Mask.ScrollView_Left.Viewport.Content.Group_CellExtra.transform
    local child = "UI/Common/Group_CellExtra"
    local count_num = 1
    for k, v in pairs(leftDownList) do
      local obj = View.self:GetRes(child, parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      lastPosY = lastPosY - hight * (count_num - 1) + offest
      obj.name = name .. "_" .. count_num
      obj.transform.localPosition = Vector3(lastPosX, lastPosY, 0)
      obj:SetActive(true)
      local num = 0 < v.num and "+" .. v.num or v.num
      SetLeftRoleDown(obj, {name = k, num = num})
      table.insert(DataModel.InstantiateList, obj)
      count_num = count_num + 1
    end
  end
end
local RefreshRightData = function()
  local space = 0
  local offestAll = 0
  local parent = View.Group_Right.Img_Mask.ScrollView_Right.Viewport.Content.transform
  local lastY_1 = -50
  local Skill_Obj = "UI/Common/Group_Skill"
  local lastY_1_Bg = 0
  local allSkillList = DataModel.SkillList
  if allSkillList and 0 < table.count(allSkillList) then
    for k, v in pairs(allSkillList) do
      local obj = View.self:GetRes(Skill_Obj, parent)
      local name = obj.name
      local hight = obj.transform:Find("Group_CellSkill/Img_Bg").transform.sizeDelta.y + offest_height
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      lastPosY = lastPosY - hight * (k - 1) + offest - lastY_1_Bg
      obj.name = name .. "_" .. k
      obj.transform.localPosition = Vector3(lastPosX, lastPosY, 0)
      obj:SetActive(true)
      table.insert(DataModel.InstantiateList, obj)
      local diffHeight = SetRightRoleSkill(obj, v, k)
      lastY_1_Bg = lastY_1_Bg + diffHeight
      space = space + hight + diffHeight
      if k == table.count(allSkillList) then
        lastY_1 = lastPosY - hight - 100 - diffHeight
        offestAll = offestAll + 100
      end
    end
  end
  local lastY_2 = -50
  local lastY_2_Bg = 0
  local Re_Obj = "UI/Common/Group_R"
  for k, v in pairs(DataModel.CA.talentList) do
    local talentCA = PlayerData:GetFactoryData(v.talentId)
    local obj = View.self:GetRes(Re_Obj, parent.transform)
    local name = obj.name
    local hight = obj.transform:Find("Group_CellR/Img_Bg").transform.sizeDelta.y + offest_height
    local lastPosY = obj.transform.localPosition.y
    local lastPosX = obj.transform.localPosition.x
    print_r(obj.transform.sizeDelta.y, hight, "富士达开发", lastPosY)
    local offest = 0
    lastPosY = lastY_1 - hight * (k - 1) + offest - lastY_2_Bg
    obj.name = name .. "_" .. k
    obj.transform.localPosition = Vector3(lastPosX, lastPosY, 0)
    obj:SetActive(true)
    table.insert(DataModel.InstantiateList, obj)
    local hight_des = SetRightRoleTalent(obj, talentCA, k)
    lastY_2_Bg = lastY_2_Bg + hight_des
    space = space + hight + hight_des
    if k == table.count(DataModel.CA.talentList) then
      lastY_2 = lastPosY - 100 - hight_des
      offestAll = offestAll + 100
    end
  end
  local lastY_3 = -50
  local lastY_3_Bg = 0
  local Break_Obj = "UI/Common/Group_B"
  for k, v in pairs(DataModel.CA.breakthroughList) do
    if 1 < k then
      local breakthroughCA = PlayerData:GetFactoryData(v.breakthroughId)
      local obj = View.self:GetRes(Break_Obj, parent.transform)
      local name = obj.name
      local hight = obj.transform:Find("Group_CellB/Img_Bg").transform.sizeDelta.y + offest_height
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      lastPosY = lastY_2 - hight * (k - 1) + offest - lastY_3_Bg
      obj.name = name .. "_" .. k
      obj.transform.localPosition = Vector3(lastPosX, lastPosY, 0)
      obj:SetActive(true)
      table.insert(DataModel.InstantiateList, obj)
      local hight_des = SetRightRoleBreak(obj, breakthroughCA, k)
      lastY_3_Bg = lastY_3_Bg + hight_des
      space = space + hight + hight_des
      if k == table.count(DataModel.CA.breakthroughList) - 1 then
        lastY_3 = lastPosY - 100 - hight_des
        offestAll = offestAll + 110
      end
    end
  end
  local lastY_4 = -50
  local lastY_4_Bg = 234
  local Equip_Obj = View.Group_Right.Img_Mask.ScrollView_Right.Viewport.Content.Group_E
  local Equip_Cell_Obj = "UI/Common/Group_Entry_Detail"
  local count_e = 0
  DataModel.PresetListElementData = {}
  local propertyList = {}
  local affixList = {}
  Equip_Obj.self:SetActive(false)
  for k, v in pairs(DataModel.Role.equips) do
    if v ~= "" then
      count_e = count_e + 1
      local severEquip = PlayerData:GetEquipById(v)
      local equipCA = {}
      if severEquip then
        equipCA = PlayerData:GetFactoryData(severEquip.id)
      end
      local list = {}
      list = PlayerData:GetRoleEquipProperty(equipCA, severEquip.lv)
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
      if 0 < table.count(severEquip.random_affix) then
        for n, m in pairs(severEquip.random_affix) do
          table.insert(affixList, m)
        end
      end
    end
  end
  if 0 < count_e then
    Equip_Obj.self:SetActive(true)
    local Group_Addition = Equip_Obj.Group_Addition
    Group_Addition.Img_Hp:SetSprite(UIConfig.AttributeType.CurrentHp.icon)
    Group_Addition.Img_Atk:SetSprite(UIConfig.AttributeType.Atk.icon)
    Group_Addition.Img_Def:SetSprite(UIConfig.AttributeType.Def.icon)
    Group_Addition.Img_Hp.Txt_Hp:SetText("生命值       " .. propertyList.healthPoint_SN.num)
    Group_Addition.Img_Atk.Txt_Atk:SetText("攻击力       " .. propertyList.attack_SN.num)
    Group_Addition.Img_Def.Txt_Def:SetText("防御力       " .. propertyList.defence_SN.num)
    local lastPosX = Equip_Obj.transform.localPosition.x
    local lastPosY = Equip_Obj.transform.localPosition.y
    lastPosY = lastY_3 - lastY_4_Bg - 50
    Equip_Obj.transform.localPosition = Vector3(lastPosX, lastPosY, 0)
    offestAll = offestAll + lastY_4_Bg - 50
    lastY_4 = lastPosY - 155
    local count = 1
    local lastY = 0
    local lastY_5 = -50
    local lastY_5_Bg = 0
    if 0 < table.count(affixList) then
      for i = 1, table.count(affixList) do
        local talentCA = PlayerData:GetFactoryData(affixList[i].id)
        if affixList[i].value > -1 then
          talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affixList[i].value * talentCA.CommonNum), talentCA.floatNum))
        else
          talentCA.descriptionShow = talentCA.description
        end
        local obj = View.self:GetRes(Equip_Cell_Obj, parent.transform)
        local name = obj.name
        local hight = obj.transform.sizeDelta.y
        local lastPosY = obj.transform.localPosition.y
        local lastPosX = obj.transform.localPosition.x
        local offest = 5
        hight = 55
        if count ~= 1 then
          lastY = lastY - hight + offest - lastY_5_Bg
        else
          lastY = lastY_4
        end
        obj.name = name .. "_" .. count
        obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
        obj:SetActive(true)
        table.insert(DataModel.InstantiateList, obj)
        local hight_des = SetDetailAffix(obj, talentCA)
        lastY_5_Bg = hight_des
        space = space + hight_des + hight
        count = count + 1
      end
    end
  end
  View.Group_Right.Img_Mask.ScrollView_Right:SetContentHeight(offestAll + space)
end
local RefreshRoleData = function()
  DataModel.InstantiateList = {}
  local Group_Left = View.Group_Left
  Group_Left.Group_Top.Txt_Level:SetText(DataModel.Role.lv)
  Group_Left.Group_Top.Txt_Name:SetText(DataModel.CA.name)
  local unit = PlayerData:GetFactoryData(DataModel.CA.viewId)
  Group_Left.Group_Top.Img_Head:SetSprite(unit.face)
  RefreshLeftData()
  View.Group_Left.Group_Property.Img_Mask.ScrollView_Left.Viewport.Content.self:SetLocalPositionY(0)
  RefreshRightData()
  View.Group_Right.Img_Mask.ScrollView_Right.Viewport.Content.self:SetLocalPositionY(0)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel.CA = PlayerData:GetFactoryData(param.id)
    DataModel.Role = PlayerData:GetRoleById(param.id)
    DataModel.AttributeData = {}
    DataModel.SkillList = {}
    local SkillList = {}
    SkillList = PlayerData:GetCardDes(DataModel.CA.id)
    for k, v in pairs(SkillList) do
      local ca = PlayerData:GetFactoryData(v.id)
      v.ExSkillList = ca.ExSkillList
      table.insert(DataModel.SkillList, {
        id = v.id,
        des = v.des,
        isEx = false,
        num = DataModel.CA.skillList[k].num
      })
      for c, d in pairs(v.ExSkillList) do
        local skill = DataManager:GetCardDes(d.ExSkillName)
        local skillList = Json.decode(skill)
        d.description = skillList.des
        d.ca = skill
        table.insert(DataModel.SkillList, {
          id = d.ExSkillName,
          des = d.description,
          ca = skill,
          isEx = true
        })
      end
    end
    local temp_data = {}
    local role = DataModel.Role
    temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tFireDamageUp = PlayerData:CountRoleAttributeById(role.id, role.skills[1] and role.skills[1].lv or 1, role.skills[2] and role.skills[2].lv or 1, role.skills[2] and role.skills[2].lv or 1, role.lv, role.awake_lv, role.resonance_lv, role.trust_lv or 1)
    DataModel.AttributeData = temp_data
    RefreshRoleData()
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
