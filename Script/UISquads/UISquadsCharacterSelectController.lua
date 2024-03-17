local View = require("UISquads/UISquadsView")
local SquadElement = require("UISquads/Model_Element")
local DataDetail = require("UISquads/UISquadsDetail")
local DataModel = require("UISquads/UISquadsDataModel")
local DataController = require("UISquads/UISquadsDataController")
local Controller = {}

function Controller:ConfirmBtn()
  local origin_cast = {}
  local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
  for i = 1, table.count(squad.role_list) do
    if squad.role_list[i] ~= nil and squad.role_list[i] ~= "" then
      table.insert(origin_cast, squad.role_list[i])
    end
  end
  local roles = {}
  local index = 0
  for k, v in pairs(DataModel.HaveSquads) do
    index = index + 1
    roles[index] = k
  end
  local connect = "|"
  local string_value = ""
  for i = 1, table.count(DataModel.currentSquad) do
    local v = DataModel.currentSquad[i]
    string_value = string_value .. v .. connect
  end
  string_value = string.sub(string_value, 1, string.len(string_value) - 1)
  if DataModel.hasLevelRole == true then
    PlayerData.currentSquad = DataModel.currentSquad
    DataController:RefreshAll()
    self.OpenView(self, false)
    return
  end
  Net:SendProto("deck.set_deck", function()
    for i = 1, 5 do
      PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list[i] = DataModel.currentSquad[i]
      DataModel.Squads[DataModel.curSquadIndex][i] = DataModel.currentSquad[i]
    end
    DataController:RefreshAll()
    self.OpenView(self, false)
  end, DataModel.curSquadIndex - 1, string_value)
end

function Controller:SetElement(element, index)
  local data = DataModel.SortRoles[index]
  data.element = element
  DataModel.Break_Role = data
  local id = data.id
  DataModel.SortRoles[index].btn = element.Img_Selected
  DataModel.SortRoles[index].mask = element.Group_InTeam
  element.Img_Bottom:SetSprite(UIConfig.CharacterBottom[data.qualityInt])
  local server = PlayerData:GetRoleById(id)
  local portraitId = server.current_skin[1]
  local ca = PlayerData:GetFactoryData(id)
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
  if server.current_skin[2] == 1 and ca.isSpine2 == 1 then
    element.Img_Mask.Img_Character:SetSprite(portrailData.State2RoleListRes)
  end
  element.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[data.qualityInt])
  element.Txt_Name:SetText(data.name)
  element.Txt_LVNum:SetText(data.lv)
  element.Img_Rarity:SetSprite(UIConfig.TipConfig[data.qualityInt + 1])
  element.Img_Selected:SetActive(index == DataModel.curSelectIndex)
  element.Group_InTeam:SetActive(DataModel.SortRoles[index].squads_index ~= 0)
  if next(DataModel.currentRoleData) ~= nil and DataModel.currentRoleData.id == id then
    DataModel.currentRoleData = data
  end
  local index_img = "Img_Index"
  for i = 1, 5 do
    element.Group_InTeam[index_img .. i]:SetActive(false)
  end
  if element.Group_InTeam[index_img .. data.squads_index] then
    element.Group_InTeam[index_img .. data.squads_index]:SetActive(true)
  end
  element.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
  element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonance_lv + 1])
  local ca = PlayerData:GetFactoryData(data.id, "UnitFactory")
  local Group_SkillColor = element.Group_SkillColor
  local cardList = PlayerData:GetRoleCardList(ca.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
  local buff = PlayerData:GetCurStationStoreBuff(tostring(id), EnumDefine.HomeSkillEnum.AddTrust)
  local groupTrust = element.Group_Trust
  groupTrust:SetActive(buff ~= nil)
  if buff ~= nil then
    groupTrust.Txt_TrustNum:SetText(string.format(GetText(80601584), math.floor(buff.param * 100)))
    local curTime = TimeUtil:GetServerTimeStamp()
    local remainTime = math.max(buff.endTime - curTime, 0)
    local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
    groupTrust.Group_Icon.Img_TrustTime:SetFilledImgAmount(remainTime / buffCA.continueTime)
  end
end

function Controller:SetSkillElement(element, index)
  local data = DataModel.currentRoleData.skills[index]
  element.Img_Icon:SetSprite(data.path)
  element.Txt_Name:SetText(data.name)
  element.Txt_SkillLV.Txt_Num:SetText(data.lv)
end

function Controller:SkillBtn(index)
  local data = DataModel.currentRoleData.skills[index]
  CommonTips.SkillTips(DataModel.currentRoleData.id, index, data)
end

local RefreshEquip = function(roleId)
  local equips = {}
  local serverEquips = PlayerData.ServerData.roles[tostring(roleId)].equips
  local unit = PlayerData:GetFactoryData(roleId, "UnitFactory")
  for k, v in pairs(serverEquips) do
    local path = ""
    local qualityInt = 0
    local hasEquip = false
    local typeInt = 0
    local factory = {}
    if v ~= "" then
      local eid = tonumber(PlayerData:GetEquipByEid(v).id)
      factory = PlayerData:GetFactoryData(eid, "EquipmentFactory")
      path = factory.iconPath
      qualityInt = factory.qualityInt + 1
      hasEquip = true
    end
    local slot = unit.equipmentSlotList[k]
    if slot ~= nil then
      typeInt = slot.typeInt
    end
    equips[k] = {
      path = path,
      qualityInt = qualityInt,
      hasEquip = hasEquip,
      typeInt = typeInt,
      roleId = roleId,
      factory = factory
    }
  end
  return equips
end

function Controller:SetEquipElement(element, index)
  local data = DataModel.currentRoleData.equips[index]
  local hasEquip = data.path ~= ""
  local Group_Equipment = element.Group_Equipment
  Group_Equipment.Img_Item:SetActive(hasEquip)
  Group_Equipment.Img_Bottom:SetActive(hasEquip)
  Group_Equipment.Img_Mask:SetActive(hasEquip)
  Group_Equipment.Group_EType:SetActive(false)
  if hasEquip then
    Group_Equipment.Img_Item:SetSprite(data.path)
    Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt])
    Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt])
    Group_Equipment.Group_EType:SetActive(true)
    Group_Equipment.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[data.typeInt])
  end
end

function Controller:EquipBtn(index)
  DataModel.hasOpenThreeView = true
  local data = DataModel.currentRoleData.equips[index]
  if data and data.hasEquip then
    local params = {}
    params = data.factory
    params.scene = 1
    params.Type = data.typeInt
    params.RoleId = data.roleId
    params.Index = index
    CommonTips.OpenEquipment(params)
  elseif data then
    local params = {
      Type = data.typeInt,
      RoleId = data.roleId,
      Index = index
    }
    UIManager:Open("UI/Equipment/EquipSelected", Json.encode(params))
  end
end

local ToPercent = function(num)
  num = num * 100 + 1.0E-6
  return num - num % 0.01
end
local GetRolesData = function()
  local roles = {}
  local index = 0
  for k, v in pairs(PlayerData.ServerData.roles) do
    local role = {}
    index = index + 1
    local id = tonumber(k)
    local unit = PlayerData:GetFactoryData(id, "UnitFactory")
    role.id = id
    role.name = unit.name
    role.qualityInt = unit.qualityInt
    role.jobInt = PlayerData:SearchRoleJobInt(unit.jobId)
    role.img = PlayerData:GetFactoryData(unit.viewId, "UnitViewFactory").roleListResUrl
    role.lv = v.lv
    role.exp = v.exp
    role.endExp = 1
    role.awake_lv = v.awake_lv
    role.resonance_lv = v.resonance_lv
    role.obtain_time = v.obtain_time
    local skills = {}
    local skillList = PlayerData:GetFactoryData(id).skillList
    local row_skill = PlayerData:GetRoleSkill(id)
    for k1, v1 in pairs(skillList) do
      local factory = PlayerData:GetFactoryData(v1.skillId)
      local lv = 1
      if row_skill[k1] then
        lv = row_skill[k1].lv
      end
      skills[k1] = {
        lv = lv,
        path = factory.iconPath,
        name = factory.name,
        id = v1.skillId
      }
    end
    role.skills = skills
    role.skillList = {}
    role.skillList = PlayerData:GetCardDes(id)
    for k, v in pairs(role.skillList) do
      v.ExSkillList = PlayerData:GetFactoryData(v.id).ExSkillList
      for c, d in pairs(v.ExSkillList) do
        local skill = DataManager:GetCardDes(d.ExSkillName)
        local skillList = Json.decode(skill)
        d.description = skillList.des
        d.ca = skill
      end
    end
    local awid = unit.awakeList[v.resonance_lv + 1] and unit.awakeList[v.resonance_lv + 1].awakeId or unit.awakeList[table.count(unit.awakeList)].awakeId
    role.maxLv = math.min(PlayerData:GetUserInfo().lv, PlayerData:GetFactoryData(99900001).roleLevelMax)
    local ConfigFactory = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    if v.lv > #ConfigFactory then
      role.endExp = 0
    else
      role.endExp = ConfigFactory[v.lv].levelUpExp
    end
    roles[index] = role
  end
  DataModel.AllRoles = roles
end
local SetSquadData = function()
  if DataModel.hasOpenThreeView == false then
    DataModel.currentRoleData = {}
    DataModel.HaveSquads = {}
    local currentRoleId = 0
    local currentSquad = DataModel.curSquad
    for k, v in pairs(currentSquad) do
      if next(v) ~= nil then
        local id = tonumber(v.unitId)
        DataModel.HaveSquads[id] = id
        if k == DataModel.currentIndex then
          currentRoleId = id
        end
      end
    end
    if currentRoleId ~= 0 then
      for k, v in pairs(DataModel.AllRoles) do
        if v.id == currentRoleId then
          DataModel.currentRoleData = v
          break
        end
      end
    end
  end
  DataModel.SortRoles = DataModel.AllRoles
end

function DataModel:RefreshSquadsInit()
  DataModel.SkillList = {}
  DataModel.SkillListAll = {}
  DataModel.isRefreshSkillList = true
  for k, v in pairs(PlayerData.ServerData.squad) do
    DataModel.Squads[k] = {}
    DataModel.SkillList[k] = {}
    for i = 1, 5 do
      if DataModel.Squads[k][i] == nil or DataModel.Squads[k][i] == "" then
        DataModel.Squads[k][i] = ""
      end
      if v.role_list[i] ~= nil then
        DataModel.Squads[k][i] = Clone(v.role_list[i])
        if v.role_list[i].id then
          DataModel.SkillList[k][i] = PlayerData:GetCardDes(v.role_list[i].id)
          for k, v in pairs(DataModel.SkillList[k][i]) do
            v.ExSkillList = PlayerData:GetFactoryData(v.id).ExSkillList
            for c, d in pairs(v.ExSkillList) do
              local skill = DataManager:GetCardDes(d.ExSkillName)
              local skillList = Json.decode(skill)
              d.description = skillList.des
              d.ca = skill
            end
          end
        end
      end
    end
  end
end

local FilterViewCallback = function(data, state, isRefresh)
  if isRefresh or DataModel.isRefreshRoleData then
    DataModel.SortRoles = {}
    local count = 1
    table.sort(DataModel.currentSortSquad, function(a, b)
      return a.squads_index < b.squads_index
    end)
    if state == 1 or state == 0 then
      for k, v in pairs(DataModel.currentSortSquad) do
        if v.squads_index == DataModel.currentIndex then
          DataModel.SortRoles[count] = v
          count = count + 1
        end
      end
    elseif state == 3 then
      for k, v in pairs(DataModel.currentSortSquad) do
        DataModel.SortRoles[count] = v
        count = count + 1
      end
    end
    for k, v in pairs(data) do
      DataModel.SortRoles[count] = v
      if DataModel.SortRoles[count].element then
        DataModel.SortRoles[count].element = nil
      end
      count = count + 1
    end
    DataModel.curSelectIndex = 1
    DataModel.SortRoles1 = DataModel.SortRoles
  end
  DataModel.SortRoles = DataModel.SortRoles1
  View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:SetDataCount(#DataModel.SortRoles)
  View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:RefreshAllElement()
  if DataModel.SortRoles[DataModel.curSelectIndex] == nil then
    View.Group_CharacterSelect.Group_Detail.self:SetActive(false)
    return
  end
  DataDetail:ShowLeftDetail(DataModel.curSelectIndex, DataModel.SortRoles[DataModel.curSelectIndex])
  local index = 0
  if next(DataModel.currentRoleData) ~= nil then
    for k, v in pairs(DataModel.SortRoles) do
      if v.id == DataModel.currentRoleData.id then
        index = k
        break
      end
    end
  end
  View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:MoveToPos(index)
  View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:HandleScrollEvent(Vector2(0, 0.8))
end
local OpenView = function(hasOpen, hasRecover, state, isRefresh)
  if hasOpen then
    UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_CharacterSelect")
  end
  View.Group_CharacterSelect.self:SetActive(hasOpen)
  if hasOpen then
    SetSquadData()
    DataModel.currentSquad = DataModel.Squads[DataModel.curSquadIndex]
    DataModel.currentSortSquad = {}
    local Sort_List = {}
    local select = 0
    for k, v in pairs(DataModel.SortRoles) do
      v.squads_index = 0
      for c, d in pairs(DataModel.currentSquad) do
        if tonumber(v.id) == tonumber(d.id) then
          v.squads_index = c
          select = select + 1
          table.insert(DataModel.currentSortSquad, v)
        end
      end
    end
    for c, d in pairs(DataModel.SortRoles) do
      if d.squads_index == 0 then
        table.insert(Sort_List, d)
      end
    end
    local isRefresh = isRefresh
    CommonFilter.InitView(EnumDefine.CommonFilterType.SquadView, View.Group_CharacterSelect.Common_Filter, Sort_List, function(data)
      FilterViewCallback(data, state, isRefresh)
    end, hasRecover)
  end
end

function Controller:RefreshFilterDate()
  SetSquadData()
end

function Controller:SearchFirstPlace()
  local count = 1
  local row = DataModel.Squads[DataModel.curSquadIndex]
  for i = 1, table.count(row) do
    if row[i] == "" or row[i] == nil or type(row[i]) == "table" and table.count(row[i]) == 0 then
      count = i
      return count
    end
  end
  return count
end

function Controller:ClickRoleElement(index)
  local data = DataModel.SortRoles[index]
  local id = data.id
  local lastId = DataModel.currentRoleData.id
  local index = 0
  local haveInSquad = false
  for k, v in pairs(DataModel.HaveSquads) do
    index = index + 1
    if id == k then
      haveInSquad = true
    end
  end
  if index >= DataModel.MaxSquadCount then
    if haveInSquad then
      DataModel.HaveSquads[id] = nil
      if DataModel.currentSquad[data.squads_index] then
        data.squads_index = 0
      end
    else
      CommonTips.OpenTips(GetText(80600128))
      return
    end
  elseif haveInSquad then
    DataModel.HaveSquads[id] = nil
  else
    DataModel.HaveSquads[id] = id
  end
  data.mask:SetActive(DataModel.HaveSquads[id] ~= nil)
  local index_img = "Img_Index"
  for i = 1, 5 do
    data.mask[index_img .. i]:SetActive(false)
  end
  local index_img = "Img_Index" .. data.squads_index
  if data.mask[index_img] then
    data.mask[index_img]:SetActive(DataModel.HaveSquads[id] ~= nil)
  end
end

function Controller:Init()
  OpenView(false)
  GetRolesData()
end

function Controller:OpenView(hasOpen, index, state, isRefresh)
  local hasRecover = false
  if index ~= nil then
    DataModel.currentIndex = index
  else
    hasRecover = true
  end
  OpenView(hasOpen, hasRecover, state, isRefresh)
  if hasOpen == false then
    View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:MoveToTop()
  end
end

function Controller:RefreshEquipView()
  if next(DataModel.currentRoleData) ~= nil then
    local id = DataModel.currentRoleData.id
    local equips = RefreshEquip(id)
    for k, v in pairs(DataModel.AllRoles) do
      if v.id == id then
        DataModel.AllRoles[k].equips = equips
        break
      end
    end
    DataModel.currentRoleData.equips = equips
  end
end

return Controller
