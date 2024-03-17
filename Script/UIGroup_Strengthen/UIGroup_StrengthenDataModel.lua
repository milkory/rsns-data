local View = require("UIGroup_Strengthen/UIGroup_StrengthenView")
local DataModel = {}
local Coefficient
DataModel.EquipExpList = {
  [1] = PlayerData:GetFactoryData(99900030).expList,
  [2] = PlayerData:GetFactoryData(99900029).expList,
  [3] = PlayerData:GetFactoryData(99900028).expList,
  [4] = PlayerData:GetFactoryData(99900031).expList,
  [5] = PlayerData:GetFactoryData(99900032).expList
}
DataModel.EquipTypeIcon = {
  [1] = "UI\\CharacterInfo\\weapon\\Weapon",
  [2] = "UI\\CharacterInfo\\weapon\\Armor",
  [3] = "UI\\CharacterInfo\\weapon\\Ornament"
}
DataModel.PropertyBase = {
  [1] = {
    type = "attack_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_attack",
    name = "攻击力"
  },
  [2] = {
    type = "healthPoint_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_health",
    name = "生命力"
  },
  [3] = {
    type = "defence_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_defense",
    name = "防御力"
  }
}
DataModel.EntryDetailMaxNum = {
  [1] = "Weapon",
  [2] = "Weapon",
  [3] = "Armor",
  [4] = "Ornaments",
  [5] = "Armor",
  [6] = "Ornaments"
}
local Clear = function()
  if DataModel.AffixList then
    for k, v in pairs(DataModel.AffixList) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear()
  Clear()
end

local Clear_Center = function()
  if DataModel.AffixList_Center then
    for k, v in pairs(DataModel.AffixList_Center) do
      Object.Destroy(v)
    end
  end
end
local affix_bg_height = 47
local baseDesHight = 24
local SetDownAffix = function(obj, row, index)
  obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.Color.White)
  if row.isTxt then
    obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.Color.Orange)
  end
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetDownAllAffix = function(Content, AffixList)
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
  local Group_Entry = "UI/CharacterInfo/weapon/Group_Entry"
  space = top_des_height
  DataModel.AffixList = {}
  local random_affix = AffixList
  local affix_list = {}
  for k, v in pairs(random_affix) do
    local row = v
    row.index = k
    table.insert(affix_list, row)
  end
  table.sort(affix_list, function(a, b)
    return a.index < b.index
  end)
  local max_affix_num = DataModel.Max_Affix_Num
  local isRegular = false
  local regularCount = 0
  for k, v in pairs(random_affix) do
    if v.value == -1 then
      isRegular = true
      regularCount = regularCount + 1
    end
  end
  local now_affix_num = table.count(random_affix)
  local streng_lv = DataModel.server.lv + DataModel.Add_lv
  local LevelNum = DataModel.EquipFactory.LevelNum
  local unLock_num = math.floor(streng_lv / LevelNum) - math.floor(DataModel.server.lv / LevelNum) + now_affix_num
  local residue_affix_num
  if max_affix_num > unLock_num then
    residue_affix_num = unLock_num - now_affix_num
  else
    residue_affix_num = max_affix_num - now_affix_num
  end
  local isFirst = false
  if 0 < residue_affix_num then
    local row = {}
    row.txt = string.format(GetText(80600770), residue_affix_num)
    row.index = 1
    row.num = residue_affix_num
    table.insert(affix_list, 1, row)
    isFirst = true
  end
  local residue_replace_num
  local diffNum = math.floor(streng_lv / LevelNum) - math.floor(DataModel.server.lv / LevelNum)
  if max_affix_num < unLock_num and now_affix_num < unLock_num and 0 < DataModel.Add_lv and 1 <= diffNum then
    residue_replace_num = unLock_num - math.max(max_affix_num, now_affix_num)
    local row = {}
    row.txt = string.format(GetText(80600771), residue_replace_num)
    row.index = 2
    row.num = residue_replace_num
    if isFirst == true then
      table.insert(affix_list, 2, row)
    else
      table.insert(affix_list, 1, row)
    end
  end
  DataModel.Add_Right_Content = {}
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local talentCA = {}
      if affix_list[i].id then
        talentCA = PlayerData:GetFactoryData(affix_list[i].id)
        if affix_list[i].value > -1 then
          talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affix_list[i].value * talentCA.CommonNum), talentCA.floatNum))
        else
          talentCA.descriptionShow = talentCA.description
        end
      else
        local _r = affix_list[i]
        table.insert(DataModel.Add_Right_Content, {
          id = _r.id,
          text = _r.txt,
          index = _r.index,
          num = _r.num
        })
        talentCA.descriptionShow = affix_list[i].txt
        talentCA.isTxt = true
      end
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = affix_bg_height
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList, obj)
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

function DataModel:RefreshRightDownContent(Group)
  local max = DataModel.Max_Affix_Num
  local ScrollView_Content = View.Group_Right.ScrollView_Content
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.server.random_affix), max))
  SetDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.server.random_affix)
end

local baseDesHight = 24
local SetCenterDownAffix = function(obj, row, index)
  obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetCenterDownAllAffix = function(Content, AffixList)
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
  local Group_Entry_Detail = "UI/CharacterInfo/weapon/Group_Entry_Detail"
  space = top_des_height
  DataModel.AffixList_Center = {}
  local random_affix = AffixList
  local affix_list = {}
  for k, v in pairs(random_affix) do
    local row = v
    row.index = k
    table.insert(affix_list, row)
  end
  table.sort(affix_list, function(a, b)
    return a.index < b.index
  end)
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local talentCA = {}
      talentCA = PlayerData:GetFactoryData(affix_list[i].id)
      if affix_list[i].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affix_list[i].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local obj = View.self:GetRes(Group_Entry_Detail, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = affix_bg_height
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList_Center, obj)
      local hight_des = SetCenterDownAffix(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Detail.Group_EXPEquip.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:RefreshCenterDownContent()
  local max = PlayerData:GetFactoryData(DataModel.LeftChooseEquipData.equipCA.equipTagId).typeName
  local ScrollView_Content = View.Group_Detail.Group_EXPEquip.ScrollView_Content
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.LeftChooseEquipData.random_affix), max))
  SetCenterDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.LeftChooseEquipData.random_affix)
end

function DataModel:RefreshCenterContent(row)
  Clear_Center()
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Detail", true)
  local Group_Detail = View.Group_Detail
  Group_Detail.self:SetActive(true)
  Group_Detail.Img_Quailty:SetSprite(UIConfig.WeaponQuality[DataModel.LeftChooseEquipData.equipCA.qualityInt + 1])
  Group_Detail.Img_Quailty:SetNativeSize()
  Group_Detail.Txt_EquipmentName:SetText("")
  Group_Detail.Group_EXPEquip.Group_NameLevel.Txt_EquipmentName:SetText(DataModel.LeftChooseEquipData.equipCA.name)
  Group_Detail.Group_EXPEquip.Group_NameLevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), DataModel.LeftChooseEquipData.lv))
  Group_Detail.Group_EXPEquip.self:SetActive(false)
  Group_Detail.Group_EXPItem.self:SetActive(false)
  if row.isItem == true then
    Group_Detail.Group_EXPItem.self:SetActive(true)
    Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(false)
    Group_Detail.Group_EXPItem.Txt_Detail:SetText(row.equipCA.des)
    Group_Detail.Group_EXPItem.Txt_Num:SetText(PlayerData:GetGoodsById(row.id).num)
    Group_Detail.Group_EXPItem.Txt_ItemName:SetText(DataModel.LeftChooseEquipData.equipCA.name)
    Group_Detail.Group_EXPItem.Group_EXPNum.Txt_EXP:SetText(row.equipCA.Experiencevalue)
  else
    Group_Detail.Group_EXPEquip.self:SetActive(true)
    if DataModel.LeftChooseEquipData.hid == "" then
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(false)
    else
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(true)
      local name = PlayerData:GetFactoryData(DataModel.LeftChooseEquipData.hid).name
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
    end
    Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(false)
    Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(false)
    if DataModel.SendLockList[DataModel.LeftChooseEquipData.eid] == nil then
      local row = {}
      row.is_locked = DataModel.LeftChooseEquipData.is_locked
      row.isChange = 0
      row.old_locked = DataModel.LeftChooseEquipData.is_locked
      DataModel.SendLockList[DataModel.LeftChooseEquipData.eid] = row
    end
    if DataModel.SendLockList[DataModel.LeftChooseEquipData.eid].is_locked == 1 then
      Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(true)
    else
      Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(true)
    end
    Group_Detail.Group_EXPEquip.Img_Property.self:SetActive(false)
    local propertyList = PlayerData:GetRoleEquipProperty(DataModel.LeftChooseEquipData.equipCA, DataModel.LeftChooseEquipData.lv)
    local pro = {}
    for k, v in pairs(propertyList) do
      if v.num ~= 0 then
        pro = v
      end
    end
    Group_Detail.Group_EXPEquip.Img_Property:SetSprite(pro.icon)
    Group_Detail.Group_EXPEquip.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(pro.num, 0) .. "</color>")
    Group_Detail.Group_EXPEquip.Img_Property.self:SetActive(true)
    DataModel:RefreshCenterDownContent()
  end
end

function DataModel:RefreshAddExpData()
  local Group_Right = View.Group_Right
  Group_Right.Txt_EquipmentLeveladd:SetActive(false)
  Group_Right.Img_Property.Txt_AtkAdd:SetActive(false)
  Group_Right.Txt_Experienceadd:SetActive(false)
  local now_exp = DataModel.server.exp
  local now_lv = DataModel.server.lv
  local equipExpList = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1]
  if equipExpList[now_lv] == nil then
    return
  end
  local now_exp_max = equipExpList[now_lv].levelUpExp * DataModel.JewelryEx
  now_exp_max = math.floor(now_exp_max)
  if DataModel.Add_lv ~= 0 then
    Group_Right.Txt_EquipmentLeveladd:SetActive(true)
    Group_Right.Txt_EquipmentLeveladd:SetText("+" .. DataModel.Add_lv)
    local now_propertyList = PlayerData:GetRoleEquipProperty(DataModel.equipCA, now_lv)
    local now_pro = {}
    for k, v in pairs(now_propertyList) do
      if v.num ~= 0 then
        now_pro = v.num
        break
      end
    end
    local before_propertyList = PlayerData:GetRoleEquipProperty(DataModel.equipCA, DataModel.server.lv + DataModel.Add_lv)
    local before_pro = {}
    for k, v in pairs(before_propertyList) do
      if v.num ~= 0 then
        before_pro = v.num
        break
      end
    end
    local diff = before_pro - now_pro
    if 0 < diff then
      Group_Right.Img_Property.Txt_AtkAdd:SetActive(true)
      Group_Right.Img_Property.Txt_AtkAdd:SetText("+" .. PlayerData:GetPreciseDecimalFloor(diff, 0))
    end
  end
  if DataModel.IsMaxLv == false then
    if DataModel.AllConsumeExp ~= 0 then
      local exp_string = "<color=#FFFFFF>" .. math.floor(now_exp) .. "</color>"
      local add_exp_string = "<color=#FFB800>" .. "+" .. math.floor(DataModel.AllConsumeExp) .. "</color>"
      Group_Right.Txt_Experienceall:SetText(exp_string .. add_exp_string .. "/" .. now_exp_max)
    else
      local exp_string = "<color=#FFFFFF>" .. math.floor(now_exp) .. "</color>"
      Group_Right.Txt_Experienceall:SetText(exp_string .. "/" .. now_exp_max)
    end
  else
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. "MAX" .. "</color>")
  end
  if DataModel.Add_lv > 0 then
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(1)
  end
  if DataModel.Add_lv == 0 then
    DataModel.Show_Exp = DataModel.Show_Exp + math.floor(DataModel.server.exp)
    local max_exp = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1][DataModel.server.lv].levelUpExp * DataModel.JewelryEx
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(DataModel.Show_Exp / max_exp)
  end
end

function DataModel:RefreshExpData()
  if DataModel.AniState == true then
    return
  end
  local now_exp = math.floor(DataModel.server.exp)
  DataModel.Add_lv = 0
  DataModel.Show_Exp = now_exp
  DataModel.AllConsumeExp = 0
  DataModel.AllGold = 0
  if tonumber(DataModel.server.lv) == tonumber(DataModel.Max_Equip_Lv) then
    DataModel.IsMaxLv = true
    local Group_Right = View.Group_Right
    Group_Right.Txt_Experienceadd:SetActive(false)
    Group_Right.Txt_Experience:SetActive(false)
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. "MAX" .. "</color>")
    Group_Right.Img_ExperienceLine:SetFilledImgAmount(1)
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(1)
  else
    local max_exp = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1][DataModel.server.lv].levelUpExp * DataModel.JewelryEx
    local Group_Right = View.Group_Right
    Group_Right.Txt_Experience:SetActive(false)
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. now_exp .. "</color>" .. "/" .. max_exp)
    Group_Right.Img_ExperienceLine:SetFilledImgAmount(now_exp / max_exp)
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(0)
  end
  DataModel:RefreshAddExpData()
end

function DataModel:InitBottomEquipData()
  local Group_Right = View.Group_Right
  DataModel.ConsumeNum = 0
  local choose_equip = 0
  DataModel.Max_Equip_Use_Num = DataModel.Max_Equip_Use_Num or DataModel.EquipFactory.UseNum
  for i = 1, DataModel.Max_Equip_Use_Num do
    local row = {}
    row.eid = ""
    DataModel.RightChooseConsumeEquip[i] = row
  end
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), choose_equip, DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
end

function DataModel:RefreshBottomEquipData()
  DataModel.AllConsumeExp = 0
  DataModel.AllGold = 0
  DataModel.ConsumeNum = 0
  DataModel.IsMax = false
  DataModel.Show_Exp = 0
  local Group_Right = View.Group_Right
  if table.count(DataModel.ChooseLeftDataIndexList) == 0 then
    DataModel.Add_lv = 0
    DataModel.TotalLv = DataModel.server.lv
    DataModel.TotalExp = DataModel.server.exp
  end
  local count = 0
  for i = 1, DataModel.Max_Equip_Use_Num do
    local row = {}
    row.eid = ""
    if DataModel.ChooseLeftDataIndexList[i] and DataModel.IsMax == false then
      count = count + 1
      local equip = DataModel.ChooseLeftDataIndexList[i]
      row.eid = equip.eid
      row.lv = equip.lv
      row.equipCA = equip.equipCA
      DataModel.ChooseLeftData[row.eid] = DataModel.ChooseLeftDataIndexList[i]
      DataModel.ChooseLeftData[row.eid].index = i
      DataModel:CalculateExp(DataModel.ChooseLeftDataIndexList[i])
      DataModel.ConsumeNum = DataModel.ConsumeNum + 1
    end
    DataModel.RightChooseConsumeEquip[i] = row
  end
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), count, DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  View.Group_UseMoney.self:SetActive(false)
  if 0 < DataModel.AllGold then
    View.Group_UseMoney.self:SetActive(true)
    View.Group_UseMoney.Txt_UseMoney:SetText(math.floor(DataModel.AllGold))
  end
  DataModel:RefreshAddExpData()
end

function DataModel:RefreshSurplus()
  View.Group_Right.Txt_Surplus:SetText(string.format(GetText(80600577), DataModel.server.rp_num))
end

function DataModel:RefreshRightContent()
  DataModel.IsMax = false
  DataModel.IsMaxLv = false
  View.Btn_Close:SetActive(false)
  DataModel:RefreshExpData()
  DataModel:InitBottomEquipData()
  DataModel:RefreshBottomEquipData()
  View.Group_Right.Group_Money.Txt_MoneyNum:SetText(PlayerData:GetUserInfo().gold)
  View.Img_EquipmentBase.Img_Equipment:SetSprite(DataModel.equipCA.tipsPath)
  Clear()
  local Group_Right = View.Group_Right
  Group_Right.self:SetActive(true)
  Group_Right.Img_Quailty:SetSprite(UIConfig.WeaponQuality[DataModel.equipCA.qualityInt + 1])
  Group_Right.Img_Quailty:SetNativeSize()
  Group_Right.Group_Nameandlevel.Txt_EquipmentName:SetText(DataModel.equipCA.name)
  Group_Right.Group_Nameandlevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), DataModel.server.lv))
  if DataModel.server.hid == "" then
    Group_Right.Txt_EquipmentCharacter:SetActive(false)
  else
    Group_Right.Txt_EquipmentCharacter:SetActive(true)
    local name = PlayerData:GetFactoryData(DataModel.server.hid).name
    Group_Right.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
  end
  Group_Right.Img_Property.self:SetActive(false)
  local propertyList = PlayerData:GetRoleEquipProperty(DataModel.equipCA, DataModel.server.lv)
  local pro = {}
  for k, v in pairs(propertyList) do
    if v.num ~= 0 then
      pro = v
    end
  end
  Group_Right.Img_Property:SetSprite(pro.icon)
  Group_Right.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(pro.num, 0) .. "</color>")
  Group_Right.Img_Property.self:SetActive(true)
  DataModel:RefreshRightDownContent()
  DataModel:RefreshSurplus()
end

function DataModel:InitEquipList()
  DataModel.ChooseLeftData = {}
  DataModel.ChooseLeftDataIndexList = {}
  DataModel.Max_Equip_Use_Num = DataModel.EquipFactory.UseNum
  DataModel.AllConsumeExp = 0
  Coefficient = nil
  DataModel.RightChooseConsumeEquip = {}
  DataModel.AllEquip = {}
  DataModel.AllCanStrengthNum = 0
  for c, d in pairs(DataModel.BtnList) do
    d.max = 0
  end
  for k, v in pairs(PlayerData:GetEquips()) do
    if v.hid == "" and k ~= DataModel.eid then
      local row = {}
      row.extra_affix = v.extra_affix
      row.lv = v.lv
      row.ex_num = v.ex_num
      row.random_affix = v.random_affix
      row.exp = v.exp
      row.rp_num = v.rp_num
      row.id = v.id
      row.hid = v.hid
      row.obtain_time = v.obtain_time
      row.is_locked = v.is_locked
      row.eid = k
      row.equipCA = PlayerData:GetFactoryData(v.id)
      row.index = 0
      if row.is_locked == 0 then
        row.index = 2
      end
      if row.is_locked == 1 then
        row.index = 3
      end
      row.isItem = false
      row.isOnPut = false
      if row.equipCA.qualityInt < 4 then
        if row.is_locked == 0 and v.lv == 1 then
          for c, d in pairs(DataModel.BtnList) do
            local type = d.type
            local isItem = d.isItem
            if row.equipCA.qualityInt <= tonumber(type) and isItem == false then
              d.max = d.max + 1
              row.isOnPut = true
            end
          end
        end
        table.insert(DataModel.AllEquip, row)
      end
    end
  end
  for k, v in pairs(PlayerData:GetMaterials()) do
    local itemCA = PlayerData:GetFactoryData(k)
    if itemCA and itemCA.EquipItemType and v.num ~= 0 and itemCA.EquipItemType == 12600393 then
      local row = {}
      row.index = 1
      row.eid = k
      row.id = k
      row.equipCA = itemCA
      row.lv = 1
      row.hid = ""
      row.is_locked = 0
      row.num = 0
      row.maxNum = v.num
      row.isItem = true
      row.isOnPut = false
      for c, d in pairs(DataModel.BtnList) do
        local type = d.type
        local isItem = d.isItem
        if row.equipCA.qualityInt <= tonumber(type) and isItem == true then
          d.max = d.max + v.num
          row.isOnPut = true
        end
      end
      table.insert(DataModel.AllEquip, row)
    end
  end
  table.sort(DataModel.AllEquip, function(a, b)
    if a.index == b.index then
      if a.equipCA.qualityInt == b.equipCA.qualityInt then
        if a.lv == b.lv then
          return a.equipCA.id < b.equipCA.id
        end
        return a.lv < b.lv
      end
      return a.equipCA.qualityInt > b.equipCA.qualityInt
    end
    return a.index < b.index
  end)
  DataModel.NowBtnListData = DataModel.BtnList[PlayerData:GetPlayerPrefs("int", "EquipType") == 0 and table.count(DataModel.BtnList) or PlayerData:GetPlayerPrefs("int", "EquipType")]
  View.Group_SortRare.self:SetActive(false)
  View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 90)
  View.Group_Right.Btn_List.Txt_List:SetText(DataModel.NowBtnListData.content)
end

function DataModel:OpenChooseEquipList(index, state)
  View.Group_Left.self:SetActive(true)
  View.Btn_Close:SetActive(true)
  DataModel.SendLockList = {}
  DataModel.LeftChooseEquipIndex = nil
  DataModel.LeftChooseEquipData = {}
  DataModel.SortDown = true
  View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
  View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.AllEquip))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  if index then
    View.Group_Left.ScrollGrid_Item.grid.self:LocateElement(index)
    DataModel:ClickLeftEquipData(index, state)
    View.self:PlayAnim("Open_All")
  else
    View.self:PlayAnim("Open_List")
  end
end

function DataModel:CloseChooseEquip()
  View.self:PlayAnim("Close_List", function()
    View.Group_Left.self:SetActive(false)
    View.Btn_Close:SetActive(false)
  end)
end

function DataModel:ClickLeftEquipData(str, state)
  local row = DataModel.AllEquip[tonumber(str)]
  local callback = function()
    if DataModel.LeftChooseEquipIndex ~= nil then
      local old_element = DataModel.AllEquip[DataModel.LeftChooseEquipIndex].element
      if old_element then
        old_element.Group_Equipment1.Img_Select:SetActive(false)
      end
    end
    DataModel.LeftChooseEquipIndex = tonumber(str)
    local eid = DataModel.LeftChooseEquipData and DataModel.LeftChooseEquipData.eid or ""
    DataModel.LeftChooseEquipData = DataModel.AllEquip[tonumber(str)]
    local element
    if row.element then
      element = row.element
      element.Group_Equipment1.Img_Select:SetActive(true)
    end
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Detail")
    local showState = View.Group_Detail.self.IsActive
    DataModel:RefreshCenterContent(row)
    if not showState then
      View.self:PlayAnim("Open_Detail")
    end
    if state == true then
      return
    end
    if row.isItem == true then
      if DataModel.ChooseLeftData[row.eid] ~= nil and row.num == row.maxNum then
        return
      end
    elseif DataModel.ChooseLeftData[row.eid] ~= nil then
      return
    end
    if row.is_locked == 1 then
      if DataModel.ChooseLeftData[row.eid] then
        if element then
          element.Group_Equipment1.Img_Choose:SetActive(false)
          element.Group_Equipment1.Btn_Cancel:SetActive(false)
        end
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel.ChooseLeftData[row.eid] = nil
        DataModel:RefreshBottomEquipData()
      end
      CommonTips.OpenTips(80600048)
      return
    end
    if tonumber(DataModel.server.lv) == DataModel.Max_Equip_Lv then
      CommonTips.OpenTips(80600584)
      return
    end
    if DataModel.IsMax == true then
      CommonTips.OpenTips(80600523)
      return
    end
    if DataModel.ConsumeNum == DataModel.Max_Equip_Use_Num then
      CommonTips.OpenTips(80600584)
      return
    end
    if DataModel.ChooseLeftData[row.eid] == nil then
      if table.count(DataModel.ChooseLeftData) == DataModel.Max_Equip_Use_Num then
        CommonTips.OpenTips(80600584)
        return
      end
      element.Group_Equipment1.Btn_Cancel:SetActive(true)
      element.Group_Equipment1.Img_Choose:SetActive(true)
      if row.isItem == true and row.num < row.maxNum then
        row.num = row.num + 1
        element.Group_Equipment1.Img_AddNum:SetActive(true)
        element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      end
      local list = {}
      list.lv = row.lv
      list.equipCA = PlayerData:GetFactoryData(row.id)
      list.index = table.count(DataModel.ChooseLeftData) + 1
      list.eid = row.eid
      list.isItem = false
      if row.isItem == true then
        list.num = 1
        list.isItem = true
      end
      list.isOnPut = row.isOnPut
      DataModel.ChooseLeftData[row.eid] = list
      table.insert(DataModel.ChooseLeftDataIndexList, list)
      DataModel:RefreshBottomEquipData()
      Clear()
      DataModel:RefreshRightDownContent()
    elseif row.isItem == true and row.num ~= row.maxNum then
      if table.count(DataModel.ChooseLeftData) == DataModel.Max_Equip_Use_Num then
        CommonTips.OpenTips(80600584)
        return
      end
      element.Group_Equipment1.Btn_Cancel:SetActive(true)
      element.Group_Equipment1.Img_Choose:SetActive(true)
      row.num = row.num + 1
      element.Group_Equipment1.Img_AddNum:SetActive(true)
      element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      local list = {}
      list.lv = row.lv
      list.equipCA = PlayerData:GetFactoryData(row.id)
      list.index = table.count(DataModel.ChooseLeftData) + 1
      list.eid = row.eid
      list.num = DataModel.ChooseLeftData[row.eid].num + 1
      list.isItem = true
      DataModel.ChooseLeftData[row.eid] = list
      table.insert(DataModel.ChooseLeftDataIndexList, list)
      DataModel:RefreshBottomEquipData()
      Clear()
      DataModel:RefreshRightDownContent()
    end
    return
  end
  if DataModel.LeftChooseEquipData and DataModel.LeftChooseEquipData.isChange and row.is_locked == 0 then
    DataModel:SendEquipLockData(callback)
    return
  elseif DataModel.LeftChooseEquipIndex and tonumber(str) == tonumber(DataModel.LeftChooseEquipIndex) then
    if row.isItem == true and row.num < row.maxNum then
      DataModel:SendEquipLockData(callback)
    end
    return
  end
  DataModel:SendEquipLockData(callback)
end

function DataModel:SortButton()
  DataModel.SortDown = not DataModel.SortDown
  if table.count(DataModel.AllEquip) == 0 then
    return
  end
  if DataModel.SortDown == true then
    View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
    table.sort(DataModel.AllEquip, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.lv == b.lv then
            return a.equipCA.id < b.equipCA.id
          end
          return a.lv < b.lv
        end
        return a.equipCA.qualityInt > b.equipCA.qualityInt
      end
      return a.index < b.index
    end)
  else
    View.Group_Left.Btn_Sort.Img_Down:SetActive(false)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(true)
    table.sort(DataModel.AllEquip, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.lv == b.lv then
            return a.equipCA.id > b.equipCA.id
          end
          return a.lv > b.lv
        end
        return a.equipCA.qualityInt < b.equipCA.qualityInt
      end
      return a.index > b.index
    end)
  end
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.AllEquip))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
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
    callback()
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipByEid(v.eid).is_locked = v.is_locked
      end
      callback()
    end, str_lock, str_unlock)
  end
end

function DataModel:OneClickPut()
  if DataModel.ConsumeNum == DataModel.Max_Equip_Use_Num then
    CommonTips.OpenTips(80600584)
    return
  end
  if DataModel.server.lv == DataModel.Max_Equip_Lv then
    CommonTips.OpenTips("强化已最大")
    return
  end
  local onPutNum = 0
  for k, v in pairs(DataModel.ChooseLeftDataIndexList) do
    local type = DataModel.NowBtnListData.type
    local isItem = DataModel.NowBtnListData.isItem
    if v.isOnPut == true and v.equipCA.qualityInt <= tonumber(type) and isItem == v.isItem then
      onPutNum = onPutNum + 1
    end
  end
  if onPutNum >= DataModel.NowBtnListData.max then
    CommonTips.OpenTips(80602255)
    return
  end
  local leftDataCount = table.count(DataModel.ChooseLeftDataIndexList)
  local allEquip = {}
  for k, v in pairs(DataModel.AllEquip) do
    if v.is_locked == 0 and v.hid == "" and k ~= DataModel.eid and v.lv == 1 then
      local type = DataModel.NowBtnListData.type
      local isItem = DataModel.NowBtnListData.isItem
      if v.equipCA.qualityInt <= tonumber(type) and isItem == v.isItem then
        if v.isItem == true then
          if v.maxNum >= v.num then
            for i = 1, v.maxNum - v.num do
              table.insert(allEquip, v)
            end
          end
        elseif DataModel.ChooseLeftData[v.eid] == nil then
          table.insert(allEquip, v)
        end
      end
    end
  end
  table.sort(allEquip, function(a, b)
    if a.equipCA.qualityInt == b.equipCA.qualityInt then
      if a.lv == b.lv then
        return a.equipCA.id < b.equipCA.id
      end
      return a.lv < b.lv
    end
    return a.equipCA.qualityInt < b.equipCA.qualityInt
  end)
  DataModel.AllConsumeExp = 0
  DataModel.IsMax = false
  DataModel.Show_Exp = 0
  DataModel.ALLExp = 0
  local Group_Right = View.Group_Right
  for i = 1, DataModel.Max_Equip_Use_Num do
    if DataModel.IsMax == false and DataModel.RightChooseConsumeEquip[i].eid == "" and allEquip[i - leftDataCount] and DataModel.RightChooseConsumeEquip[i] then
      local row = {}
      local equip = allEquip[i - leftDataCount]
      row.lv = equip.lv
      row.equipCA = equip.equipCA
      row.eid = equip.eid
      if equip.isItem == true and equip.num < equip.maxNum then
        equip.num = equip.num + 1
        row.num = equip.num
      end
      row.isOnPut = equip.isOnPut
      row.isItem = equip.isItem
      DataModel.ChooseLeftData[row.eid] = row
      DataModel.ChooseLeftData[row.eid].index = i
      DataModel.ChooseLeftDataIndexList[i] = row
      DataModel.ConsumeNum = DataModel.ConsumeNum + 1
      DataModel.RightChooseConsumeEquip[i] = row
    end
    if DataModel.ChooseLeftDataIndexList[i] then
      DataModel:CalculateExp(DataModel.ChooseLeftDataIndexList[i])
    end
  end
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), table.count(DataModel.ChooseLeftDataIndexList), DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  View.Group_UseMoney.self:SetActive(false)
  if 0 < DataModel.AllGold then
    View.Group_UseMoney.self:SetActive(true)
    View.Group_UseMoney.Txt_UseMoney:SetText(math.floor(DataModel.AllGold))
  end
  DataModel:RefreshAddExpData()
  DataModel:Clear()
  DataModel:RefreshRightDownContent()
end

function DataModel:CalculateExp(row)
  local exp = 0
  local base = 0
  local add_exp = 0
  Coefficient = Coefficient or DataModel.EquipFactory.Coefficient
  if row.isItem == true then
    exp = PlayerData:GetFactoryData(row.eid).equipExp
  else
    local typeIndex = PlayerData:GetTypeInt("enumEquipTypeList", row.equipCA.equipTagId)
    local jewelryEx = 1
    if typeIndex == 3 then
      jewelryEx = DataModel.EquipFactory.jewelryEx
    end
    local index = row.equipCA.qualityInt + 1
    if DataModel.EquipFactory[row.equipCA.quality] then
      base = DataModel.EquipFactory[row.equipCA.quality]
    end
    if DataModel.EquipExpList[index] then
      local equipExpList = DataModel.EquipExpList[index]
      local list = equipExpList[tonumber(row.lv)]
      if list then
        add_exp = list.EnergyMax * Coefficient * jewelryEx
      end
    end
    exp = add_exp + base
  end
  DataModel.AllConsumeExp = DataModel.AllConsumeExp + exp
  DataModel.AllGold = math.floor(DataModel.AllGold + exp * 10)
  DataModel:CalculateEquipNeedExp()
end

function DataModel:CalculateEquipNeedExp(exp)
  DataModel.TotalLv = DataModel.server.lv
  DataModel.TotalExp = DataModel.server.exp
  DataModel.Add_lv = 0
  local equip_lv = DataModel.TotalLv
  local equip_exp = DataModel.TotalExp
  local equipExpList = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1]
  local equip_exp_max = equipExpList[equip_lv] and equipExpList[equip_lv].EnergyMax or 0
  equip_exp_max = math.floor((equip_exp_max + equip_exp) * DataModel.JewelryEx)
  if equipExpList[equip_lv] then
    local now_exp_max = equipExpList[equip_lv].levelUpExp * DataModel.JewelryEx
    now_exp_max = math.floor(now_exp_max)
    local now_lv = equip_lv
    local residue_exp = DataModel.AllConsumeExp
    while 0 <= residue_exp do
      local stage_exp
      if now_lv == equip_lv then
        stage_exp = now_exp_max - equip_exp
      else
        stage_exp = equipExpList[now_lv].levelUpExp * DataModel.JewelryEx
      end
      DataModel.Add_lv = DataModel.Add_lv + 1
      DataModel.TotalLv = DataModel.TotalLv + 1
      now_lv = now_lv + 1
      residue_exp = residue_exp - stage_exp
      if residue_exp == 0 then
        DataModel.Show_Exp = 0
        break
      end
      if residue_exp < 0 then
        residue_exp = residue_exp + stage_exp
        DataModel.Show_Exp = residue_exp
        DataModel.Add_lv = DataModel.Add_lv - 1
        DataModel.TotalLv = DataModel.TotalLv - 1
        break
      end
      if now_lv == DataModel.Max_Equip_Lv then
        DataModel.Show_Exp = 0
        DataModel.IsMax = true
        break
      end
    end
    DataModel.TotalExp = DataModel.Show_Exp
    if DataModel.IsMax and DataModel.Add_lv + equip_lv == DataModel.Max_Equip_Lv then
      DataModel.AllGold = 0
      local aa = equipExpList[#equipExpList].EnergyMax * DataModel.JewelryEx - equip_exp_max
      local bb = aa * 10
      DataModel.AllGold = bb
    end
  end
end

function DataModel:RefreshBottomEntryButton()
  local Group_Windows = View.Group_Windows
  DataModel.isSameType = false
  if DataModel.server.extra_affix and table.count(DataModel.server.extra_affix) > 0 then
    local max = DataModel.Max_Affix_Num
    if DataModel.EntryIndex == nil then
      Group_Windows.Btn_Confirm.Img_Use:SetActive(true)
      Group_Windows.Btn_Confirm.Img_Useless:SetActive(false)
      local num = DataModel.IsImmobilization == true and 1 or 0
      num = 1
      DataModel.EntryIndex = table.count(DataModel.server.random_affix) + num
      local count = 0
      for k, v in pairs(DataModel.server.random_affix) do
        if v.id == DataModel.server.extra_affix.id then
          count = tonumber(k) + 1
          break
        end
      end
      if count and 0 < count then
        DataModel.isSameType = true
        DataModel.EntryIndex = count
      end
      if DataModel.server.extra_affix.id and table.count(DataModel.server.random_affix) == 0 then
        DataModel.EntryIndex = 1
      end
    end
  end
  if DataModel.EntryIndex and DataModel.isSameType == false and DataModel.EntryIndex > table.count(DataModel.server.random_affix) and DataModel.IsMaxAffix == true then
    DataModel.EntryIndex = nil
  end
  if table.count(DataModel.server.extra_affix) > 0 and DataModel.EntryIndex ~= nil then
    Group_Windows.Btn_Confirm.Img_Use:SetActive(true)
    Group_Windows.Btn_Confirm.Img_Useless:SetActive(false)
  else
    Group_Windows.Btn_Confirm.Img_Use:SetActive(false)
    Group_Windows.Btn_Confirm.Img_Useless:SetActive(true)
  end
end

function DataModel:RefreshUseItemTopPage()
  local Group_Windows = View.Group_Windows
  Group_Windows.Img_ItemChangeEntry:SetActive(true)
  if Group_Windows.Img_NoHaveChangeEntry.IsActive == true then
    Group_Windows.Img_NoHaveChangeEntry:SetActive(false)
  end
  local row = DataModel.UseItemList[tonumber(DataModel.ChooseUseItemIndex)]
  local Img_ItemChangeEntry = View.Group_Windows.Img_ItemChangeEntry
  local Group_Equipment1 = Img_ItemChangeEntry.Group_Equipment1
  Img_ItemChangeEntry.Txt_ChangeEntryTitle:SetText(row.itemCA.name)
  Img_ItemChangeEntry.Txt_Entry:SetText(row.itemCA.briefText)
  Img_ItemChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
  Group_Equipment1.Img_Item:SetSprite(row.itemCA.iconPath)
  Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.itemCA.qualityInt + 1])
  Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.itemCA.qualityInt + 1])
  Group_Equipment1.Txt_EquipmentLevel:SetText(1)
  Group_Equipment1.Img_Select:SetActive(false)
  Group_Equipment1.Btn_Cancel:SetActive(true)
  Group_Equipment1.Group_Face:SetActive(false)
  Group_Equipment1.Img_Choose:SetActive(false)
  Group_Equipment1.Img_Lock:SetActive(false)
  Group_Equipment1.Img_NoType:SetActive(false)
end

function DataModel:RefreshEntryTop()
  local Group_Windows = View.Group_Windows
  Group_Windows.Img_HaveChangeEntry:SetActive(false)
  Group_Windows.Img_NoHaveChangeEntry:SetActive(false)
  Group_Windows.Img_ItemChangeEntry:SetActive(false)
  if table.count(DataModel.server.extra_affix) > 0 then
    Group_Windows.Img_HaveChangeEntry:SetActive(true)
    local Img_HaveChangeEntry = View.Group_Windows.Img_HaveChangeEntry
    Img_HaveChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
    local talentCA = PlayerData:GetFactoryData(DataModel.server.extra_affix.id)
    if DataModel.server.extra_affix.value > -1 then
      local descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(DataModel.server.extra_affix.value * talentCA.CommonNum), talentCA.floatNum))
      Img_HaveChangeEntry.Txt_Entry:SetText(descriptionShow)
    else
      Img_HaveChangeEntry.Txt_Entry:SetText(talentCA.description)
    end
  else
    Group_Windows.Img_NoHaveChangeEntry:SetActive(true)
  end
  local Img_HaveChangeEntry = View.Group_Windows.Img_HaveChangeEntry
  Img_HaveChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
end

function DataModel:RefreshChangeWindows()
  local Group_Windows = View.Group_Windows
  Group_Windows.Txt_RemainingChangeNum:SetText(string.format(GetText(80600576), DataModel.server.rp_num))
  Group_Windows.Group_UseItem.self:SetActive(false)
  Group_Windows.Txt_Tips:SetActive(true)
  DataModel:RefreshEntryTop()
  local max = DataModel.Max_Affix_Num
  DataModel.EntryIndex = nil
  DataModel.IsImmobilization = false
  for k, v in pairs(DataModel.server.random_affix) do
    if v.value == -1 then
      DataModel.IsImmobilization = true
      break
    end
  end
  DataModel.RandomAffixLits = {}
  for k, v in pairs(DataModel.server.random_affix) do
    local row = v
    row.index = k
    table.insert(DataModel.RandomAffixLits, row)
  end
  table.sort(DataModel.RandomAffixLits, function(a, b)
    return a.index < b.index
  end)
  DataModel.SearchAffixSameList = {}
  if table.count(DataModel.server.random_affix) == max then
    DataModel.IsMaxAffix = true
  end
  DataModel:RefreshBottomEntryButton()
  View.Group_Windows.Group_UseItem.self:SetActive(false)
  View.Group_Windows.Txt_Tips:SetActive(true)
  View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
  DataModel.EntryAffixList = {}
  Group_Windows.ScrollGrid_Entry.grid.self:SetDataCount(max)
  Group_Windows.ScrollGrid_Entry.grid.self:RefreshAllElement()
end

function DataModel:EntrySetGrid(element, elementIndex)
  local row = DataModel.RandomAffixLits[elementIndex]
  DataModel.EntryAffixList[tonumber(elementIndex)] = {}
  DataModel.EntryAffixList[tonumber(elementIndex)].element = element
  local Btn_Entry = element.Btn_Entry
  Btn_Entry:SetClickParam(elementIndex)
  if row then
    local talentCA = PlayerData:GetFactoryData(row.id)
    if row.value > -1 then
      local descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(row.value * talentCA.CommonNum), talentCA.floatNum))
      Btn_Entry.Txt_Entry:SetText(descriptionShow)
    else
      Btn_Entry.Txt_Entry:SetText(talentCA.description)
    end
    if DataModel.SearchAffixSameList[tonumber(talentCA.id)] == nil then
      DataModel.SearchAffixSameList[tonumber(talentCA.id)] = true
    end
  else
    Btn_Entry.Txt_Entry:SetText("")
  end
  if elementIndex == 1 and DataModel.IsImmobilization == true then
    Btn_Entry.Img_Lock:SetActive(true)
    Btn_Entry.Img_Change:SetActive(false)
    Btn_Entry.Img_CannotSelect:SetActive(false)
  elseif DataModel.EntryIndex then
    if DataModel.EntryIndex == tonumber(elementIndex) then
      Btn_Entry.Img_Lock:SetActive(false)
      Btn_Entry.Img_Change:SetActive(true)
      Btn_Entry.Img_CannotSelect:SetActive(false)
    else
      Btn_Entry.Img_Lock:SetActive(false)
      Btn_Entry.Img_CannotSelect:SetActive(true)
      Btn_Entry.Img_Change:SetActive(false)
    end
  else
    Btn_Entry.Img_Lock:SetActive(false)
    if row == nil then
      Btn_Entry.Img_CannotSelect:SetActive(true)
      Btn_Entry.Img_Change:SetActive(false)
    else
      Btn_Entry.Img_CannotSelect:SetActive(false)
      Btn_Entry.Img_Change:SetActive(true)
    end
  end
  Btn_Entry.Img_Select:SetActive(false)
  Btn_Entry.Img_Choose:SetActive(false)
  if DataModel.EntryIndex and tonumber(elementIndex) == DataModel.EntryIndex then
    Btn_Entry.Img_Select:SetActive(true)
    Btn_Entry.Img_Choose:SetActive(true)
  end
end

function DataModel:EntryClickSetGrid(elementIndex)
  if tonumber(elementIndex) == DataModel.EntryIndex then
    return
  end
  if tonumber(elementIndex) == 1 and DataModel.IsImmobilization == true then
    CommonTips.OpenTips(80601579)
    return
  end
  if DataModel.isSameType == true then
    CommonTips.OpenTips(80601953)
    return
  end
  if DataModel.IsMaxAffix == false and DataModel.EntryIndex then
    CommonTips.OpenTips(80600677)
    return
  end
  local Btn_Entry = DataModel.EntryAffixList[tonumber(elementIndex)].element.Btn_Entry
  if DataModel.EntryIndex then
    local Btn_Entry_Old = DataModel.EntryAffixList[tonumber(DataModel.EntryIndex)].element.Btn_Entry
    Btn_Entry_Old.Img_Select:SetActive(false)
    Btn_Entry_Old.Img_Choose:SetActive(false)
  end
  if Btn_Entry.Img_CannotSelect.IsActive == false and (table.count(DataModel.server.extra_affix) > 0 or DataModel.EntryIndex) then
    DataModel.EntryIndex = tonumber(elementIndex)
    Btn_Entry.Img_Select:SetActive(true)
    Btn_Entry.Img_Choose:SetActive(true)
  end
  DataModel:RefreshBottomEntryButton()
end

function DataModel:ClickChangeWindows()
  DataModel.IsSend = false
  DataModel.IsMaxAffix = false
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Windows")
  View.Group_Windows.self:SetActive(true)
  DataModel:RefreshChangeWindows()
  if DataModel.EntryIndex and DataModel.IsMaxAffix == false then
    local Btn_Entry = DataModel.EntryAffixList[DataModel.EntryIndex].element.Btn_Entry
    Btn_Entry.Img_CannotSelect:SetActive(false)
    Btn_Entry.Img_Select:SetActive(true)
    Btn_Entry.Img_Choose:SetActive(true)
  end
  View.self:PlayAnim("Open_Windows")
end

function DataModel:CloseChangeWindows()
  View.self:PlayAnim("Close_Windows", function()
    DataModel.ChooseUseItemIndex = nil
    DataModel.UseItemList = {}
    View.Group_Windows.self:SetActive(false)
  end)
end

function DataModel:RefreshUseItemBottomState()
  if DataModel.ChooseUseItemIndex and DataModel.UseItemList[DataModel.ChooseUseItemIndex] then
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Useless.self:SetActive(false)
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Use.self:SetActive(true)
  else
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Useless.self:SetActive(true)
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Use.self:SetActive(false)
  end
end

local SearchEquipmentAffix = function(id, Entrylist)
  local EquipmentEntryList = PlayerData:GetFactoryData(id).EquipmentEntryList
  local count = 0
  for k, v in pairs(EquipmentEntryList) do
    for c, d in pairs(Entrylist) do
      if v.id == d.id then
        count = count + 1
      end
    end
  end
  if count == table.count(EquipmentEntryList) then
    return true
  end
  return false
end

function DataModel:RefreshUseItem()
  if DataModel.ChooseUseItemIndex == nil then
    DataModel.ChooseUseItemIndex = nil
  end
  DataModel.UseItemList = {}
  local EquipmentEntryList = {}
  for c, d in pairs(DataModel.equipCA.randomSkillList) do
    local EquipmentEntryList_CA = PlayerData:GetFactoryData(d.skillId).EquipmentEntryList
    for k, v in pairs(EquipmentEntryList_CA) do
      table.insert(EquipmentEntryList, v)
    end
  end
  for k, v in pairs(PlayerData:GetItems()) do
    local itemCA = PlayerData:GetFactoryData(k)
    if itemCA and itemCA.EquipItemType and itemCA.EquipItemType ~= 12600393 and (DataModel.equipCA.campTagId == -1 or itemCA.campType == -1 or itemCA.campType == DataModel.equipCA.campTagId) then
      if itemCA.EntryItemList[1] and DataModel.SearchAffixSameList[tonumber(itemCA.EntryItemList[1].Entry)] == nil then
        local row = {}
        if v.num > 0 then
          for c, d in pairs(v) do
            row[c] = d
          end
          row.itemCA = itemCA
          for _k, _v in pairs(EquipmentEntryList) do
            local state = false
            if k == "11400057" then
              state = SearchEquipmentAffix(itemCA.EntryItemList[1].Entry, EquipmentEntryList)
            end
            if _v.id == itemCA.EntryItemList[1].Entry or state == true then
              table.insert(DataModel.UseItemList, row)
              break
            end
          end
        end
      end
      if table.count(itemCA.EntryItemList) == 0 then
        local row = {}
        if v.num > 0 then
          for c, d in pairs(v) do
            row[c] = d
          end
          row.itemCA = itemCA
          table.insert(DataModel.UseItemList, row)
        end
      end
    end
  end
  if table.count(DataModel.UseItemList) == 0 then
    CommonTips.OpenTips("暂无词缀替换道具")
    return
  else
    View.Group_Windows.Group_UseItem.self:SetActive(true)
    View.Group_Windows.Txt_Tips:SetActive(false)
    View.Group_Windows.ScrollGrid_Entry.self:SetActive(false)
    DataModel:RefreshUseItemBottomState()
    View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.UseItemList))
    View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:RefreshAllElement()
    DataModel.ChooseUseItemIndex = nil
    DataModel:ChooseEquipItem(1)
  end
end

function DataModel:ChooseEquipItem(str)
  if tonumber(str) == DataModel.ChooseUseItemIndex then
    return
  end
  if DataModel.ChooseUseItemIndex then
    local row_old = DataModel.UseItemList[DataModel.ChooseUseItemIndex]
    local element = row_old.element
    element.Group_Equipment1.Img_Select:SetActive(false)
  end
  DataModel.ChooseUseItemIndex = tonumber(str)
  local row = DataModel.UseItemList[DataModel.ChooseUseItemIndex]
  local element = row.element
  element.Group_Equipment1.Img_Select:SetActive(true)
  DataModel:RefreshUseItemBottomState()
  DataModel:RefreshUseItemTopPage()
end

function DataModel:ClickGroupUseItem()
  DataModel:RefreshUseItem()
end

function DataModel:CloseGroupUseItem()
  if DataModel.ChooseUseItemIndex then
    View.Group_Windows.Img_ItemChangeEntry:SetActive(false)
  end
  DataModel.UseItemList = {}
  DataModel.ChooseUseItemIndex = nil
  View.Group_Windows.Group_UseItem.self:SetActive(false)
  View.Group_Windows.Txt_Tips:SetActive(true)
  View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
  DataModel.RefreshEntryTop()
end

function DataModel:DelEnrty()
  local callback = function()
    Net:SendProto("equip.set_affix", function(json)
      print_r(json)
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel.server = json.equip
      DataModel:RefreshChangeWindows()
    end, DataModel.eid, -1)
  end
  CommonTips.OnPrompt(GetText(80601666), nil, nil, callback, nil)
end

function DataModel:ConfirmEntry()
  if View.Group_Windows.Btn_Confirm.Img_Use.IsActive == false then
    return
  end
  local callback = function()
    Net:SendProto("equip.set_affix", function(json)
      print_r(json)
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel.server = json.equip
      DataModel.ChooseUseItemIndex = nil
      DataModel:RefreshChangeWindows()
      DataModel.IsSend = true
    end, DataModel.eid, DataModel.EntryIndex - 1)
  end
  CommonTips.OnPrompt(GetText(80601578), nil, nil, callback, nil)
end

function DataModel:UseItemEntry()
  if DataModel.ChooseUseItemIndex == nil then
    return
  end
  if DataModel.server.extra_affix and table.count(DataModel.server.extra_affix) > 0 then
    CommonTips.OpenTips(80601652)
    return
  end
  local callback = function()
    local itemID = ""
    local items = {}
    if DataModel.ChooseUseItemIndex then
      local row = DataModel.UseItemList[tonumber(DataModel.ChooseUseItemIndex)]
      itemID = row.id
      items[tostring(itemID)] = 1
    end
    Net:SendProto("equip.set_item_affix", function(json)
      DataModel.server = json.equip
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel:RefreshChangeWindows()
      if itemID ~= "" then
        PlayerData:RefreshUseItems(items)
      end
      View.Group_Windows.Group_UseItem.self:SetActive(false)
      View.Group_Windows.Txt_Tips:SetActive(true)
      View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
      if DataModel.EntryIndex and DataModel.IsMaxAffix == false then
        local Btn_Entry = DataModel.EntryAffixList[DataModel.EntryIndex].element.Btn_Entry
        Btn_Entry.Img_CannotSelect:SetActive(false)
        Btn_Entry.Img_Select:SetActive(true)
        Btn_Entry.Img_Choose:SetActive(true)
      end
    end, DataModel.eid, itemID)
  end
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "EquipUseItemKey"
  checkTipParam.checkTipType = 1
  checkTipParam.showDanger = true
  CommonTips.OnPrompt(GetText(80601577), nil, nil, callback, nil, nil, nil, nil, checkTipParam)
end

local tempAddLv = 0

function DataModel:RefreshAniSetFilledImgAmount()
  if DataModel.Add_lv > 0 then
  end
end

function DataModel:SelectBtnList(index)
  if DataModel.BtnListIndex and index == DataModel.BtnListIndex then
    return
  end
  local row = DataModel.BtnList[index]
  local element = View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid[index]
  element.Img_Selected:SetActive(true)
  if DataModel.BtnListIndex then
    View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid[DataModel.BtnListIndex].Img_Selected:SetActive(false)
  end
  DataModel.BtnListIndex = index
  PlayerData:SetPlayerPrefs("int", "EquipType", index)
  DataModel.NowBtnListData = DataModel.BtnList[DataModel.BtnListIndex]
  View.Group_Right.Btn_List.Txt_List:SetText(DataModel.NowBtnListData.content)
end

return DataModel
