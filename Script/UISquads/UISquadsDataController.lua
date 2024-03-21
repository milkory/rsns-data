local DataModel = require("UISquads/UISquadsDataModel")
local View = require("UISquads/UISquadsView")
local SquadController = require("UISquads/Controller_Squad")

function GetPlayerRoleData(roleId)
  if roleId == nil or roleId == "" then
    return {}
  end
  local roleData = PlayerData:GetRoleById(roleId)
  if next(roleData) == nil then
    return {}
  end
  local roleInfo = {}
  roleInfo.unitId = roleData.id
  roleInfo.unitViewId = roleData.current_skin[1]
  roleInfo.lv = roleData.lv
  roleInfo.breakthroughLv = 0
  local roleCA = PlayerData:GetFactoryData(roleId)
  local awakeLv = roleData.awake_lv or 1
  if awakeLv == #roleCA.breakthroughList - 1 and PlayerData:IsRoleAwakeLock(roleId) then
    awakeLv = awakeLv - 1
  end
  roleInfo.awakeLv = awakeLv
  local resonanceLv = roleData.resonance_lv or 1
  if resonanceLv == #roleCA.talentList and PlayerData:IsRoleResonanceLock(roleId) then
    resonanceLv = resonanceLv - 1
  end
  roleInfo.resonanceLv = resonanceLv
  roleInfo.resonanceStage = 0
  if roleData.trust_lv == nil then
    roleInfo.trustLv = 0
  else
    roleInfo.trustLv = roleData.trust_lv
  end
  roleInfo.skill1Lv = roleData.skills[1] ~= nil and roleData.skills[1].lv or 1
  roleInfo.skill2Lv = roleData.skills[2] ~= nil and roleData.skills[2].lv or 1
  roleInfo.skill3Lv = roleData.skills[3] ~= nil and roleData.skills[3].lv or 1
  roleInfo.equip1Id = roleData.equips[1] ~= "" and roleData.equips[1] and PlayerData:GetEquipById(roleData.equips[1]).id or -1
  roleInfo.equip1Lv = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).lv or 1
  roleInfo.e1s1Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["0"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["0"].id or -1
  roleInfo.e1s1NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["0"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["0"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["0"].value * 10000 or 0
  roleInfo.e1s2Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["1"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["1"].id or -1
  roleInfo.e1s2NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["1"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["1"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["1"].value * 10000 or 0
  roleInfo.e1s3Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["2"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["2"].id or -1
  roleInfo.e1s3NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["2"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["2"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["2"].value * 10000 or 0
  roleInfo.e1s4Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["3"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["3"].id or -1
  roleInfo.e1s4NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["3"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["3"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["3"].value * 10000 or 0
  roleInfo.e1s5Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["4"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["4"].id or -1
  roleInfo.e1s5NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["4"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["4"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["4"].value * 10000 or 0
  roleInfo.e1s6Id = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["5"] and PlayerData:GetEquipById(roleData.equips[1]).random_affix["5"].id or -1
  roleInfo.e1s6NumSN = roleData.equips[1] ~= "" and PlayerData:GetEquipById(roleData.equips[1]).random_affix["5"] and -1 < PlayerData:GetEquipById(roleData.equips[1]).random_affix["5"].value and PlayerData:GetEquipById(roleData.equips[1]).random_affix["5"].value * 10000 or 0
  roleInfo.equip2Id = roleData.equips[2] ~= "" and roleData.equips[2] and PlayerData:GetEquipById(roleData.equips[2]).id or -1
  roleInfo.equip2Lv = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).lv or 1
  roleInfo.e2s1Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["0"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["0"].id or -1
  roleInfo.e2s1NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["0"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["0"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["0"].value * 10000 or 0
  roleInfo.e2s2Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["1"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["1"].id or -1
  roleInfo.e2s2NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["1"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["1"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["1"].value * 10000 or 0
  roleInfo.e2s3Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["2"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["2"].id or -1
  roleInfo.e2s3NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["2"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["2"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["2"].value * 10000 or 0
  roleInfo.e2s4Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["3"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["3"].id or -1
  roleInfo.e2s4NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["3"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["3"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["3"].value * 10000 or 0
  roleInfo.e2s5Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["4"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["4"].id or -1
  roleInfo.e2s5NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["4"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["4"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["4"].value * 10000 or 0
  roleInfo.e2s6Id = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["5"] and PlayerData:GetEquipById(roleData.equips[2]).random_affix["5"].id or -1
  roleInfo.e2s6NumSN = roleData.equips[2] ~= "" and PlayerData:GetEquipById(roleData.equips[2]).random_affix["5"] and -1 < PlayerData:GetEquipById(roleData.equips[2]).random_affix["5"].value and PlayerData:GetEquipById(roleData.equips[2]).random_affix["5"].value * 10000 or 0
  roleInfo.equip3Id = roleData.equips[3] ~= "" and roleData.equips[3] and PlayerData:GetEquipById(roleData.equips[3]).id or -1
  roleInfo.equip3Lv = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).lv or 1
  roleInfo.e3s1Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["0"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["0"].id or -1
  roleInfo.e3s1NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["0"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["0"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["0"].value * 10000 or 0
  roleInfo.e3s2Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["1"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["1"].id or -1
  roleInfo.e3s2NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["1"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["1"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["1"].value * 10000 or 0
  roleInfo.e3s3Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["2"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["2"].id or -1
  roleInfo.e3s3NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["2"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["2"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["2"].value * 10000 or 0
  roleInfo.e3s4Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["3"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["3"].id or -1
  roleInfo.e3s4NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["3"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["3"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["3"].value * 10000 or 0
  roleInfo.e3s5Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["4"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["4"].id or -1
  roleInfo.e3s5NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["4"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["4"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["4"].value * 10000 or 0
  roleInfo.e3s6Id = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["5"] and PlayerData:GetEquipById(roleData.equips[3]).random_affix["5"].id or -1
  roleInfo.e3s6NumSN = roleData.equips[3] ~= "" and PlayerData:GetEquipById(roleData.equips[3]).random_affix["5"] and -1 < PlayerData:GetEquipById(roleData.equips[3]).random_affix["5"].value and PlayerData:GetEquipById(roleData.equips[3]).random_affix["5"].value * 10000 or 0
  roleInfo.cardNum1 = roleData.cardNum1 == nil and -1 or roleData.cardNum1
  roleInfo.cardNum2 = roleData.cardNum2 == nil and -1 or roleData.cardNum2
  return roleInfo
end

local module = {
  Serialize = function(self)
    local status = DataModel.InitParams
    status.levelChainId = DataModel.levelChainId
    status.curSquadIndex = DataModel.curSquadIndex
    status.curDetailIndex = DataModel.curDetailIndex
    status.curSelectIndex = DataModel.curSelectIndex
    status.difficulty = DataModel.difficulty
    status.enemy_ids = DataModel.enemy_ids
    status.enemyLevelOffset = DataModel.enemyLevelOffset
    status.secondWeatherList = DataModel.secondWeatherList
    status.trainWeaponSkill = DataModel.trainWeaponSkill
    return status
  end,
  Deserialize = function(self, status)
    if status == nil then
      return nil
    end
    DataModel.Current = status.Current
    DataModel.RoleData = nil
    DataModel.curLevelId = nil
    DataModel.isHighChallenge = nil
    if status.Current ~= "MainUI" then
      DataModel.curLevelId = PlayerData.BattleInfo.battleStageId
    end
    DataModel.curDetailIndex = status.curDetailIndex or 1
    DataModel.curSquadIndex = status.curSquadIndex or 1
    if status.squadIndex ~= nil then
      DataModel.curSquadIndex = status.squadIndex
    end
    if DataModel.curSquadIndex == 0 then
      DataModel.curSquadIndex = 1
    end
    if status.hasOpenThreeView ~= nil then
      DataModel.hasOpenThreeView = status.hasOpenThreeView
    end
    DataModel.eventId = status.eventId
    DataModel.level_key = status.level_key
    DataModel.minEnemyLevel = status.minEnemyLevel or 1
    DataModel.difficulty = status.difficulty or 1
    DataModel.bgId = status.bgId
    DataModel.enemyLevel = status.enemyLevel
    DataModel.enemyRn = status.enemyRn
    DataModel.lineWeatherIdList = status.lineWeatherIdList
    DataModel.lineWeatherRateSN = status.lineWeatherRateSN
    DataModel.areaId = status.areaId
    DataModel.enemy_ids = status.enemy_ids
    DataModel.enemyLevelOffset = status.enemyLevelOffset
    DataModel.secondWeatherList = status.secondWeatherList
    DataModel.trainWeaponSkill = status.trainWeaponSkill
  end
}

function module:RefreshAll()
  local levelData
  DataModel.isUseLevelRole = false
  if DataModel.curLevelId == nil then
    levelData = nil
  else
    levelData = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
  end
  if self:CheckLevel(levelData) == true then
    DataModel.hasLevelRole = true
  else
    if DataModel.curSquadIndex == 0 then
      DataModel.curSquadIndex = 1
    end
    PlayerData.currentSquad = {}
    local curRoleList = PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list
    for i = 1, 5 do
      local temp = {}
      temp = curRoleList[i]
      if temp and temp.id == "" then
        temp.id = nil
      end
      table.insert(PlayerData.currentSquad, temp)
    end
    DataModel.hasLevelRole = false
  end
  self:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
  if DataModel.levelChainId == nil then
    View.Group_Tab.self:SetActive(true)
  end
  if DataModel.hasLevelRole == true then
    View.Group_Tab:SetActive(false)
    View.Btn_Clear:SetActive(false)
    View.Btn_QuickFormation:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_LockMode")
    View.Group_LockMode:SetActive(true)
    View.Group_LockMode.Group_.Txt_:SetText(GetText(80600944))
  else
    SquadController.RefreshTab(4)
    View.Group_Tab:SetActive(true)
    View.Btn_Clear:SetActive(true)
    View.Btn_QuickFormation:SetActive(true)
    View.Group_LockMode:SetActive(false)
  end
  if View.Group_Detail ~= nil then
    View.Group_Detail.self:SetActive(false)
  end
  SquadController.SetStartActive(DataModel.Current)
  SquadController.ShowDetail(DataModel.curSquadIndex)
  SquadController.RefreshRoles()
end

function module:CheckLevel(levelData)
  if levelData == nil then
    return false
  end
  if DataModel.Current == DataModel.Enum.College then
    return true
  end
  if #levelData.levelRoleList > 0 then
    return true
  end
  return false
end

function module:SetSquad(currentSquad, squadCount)
  DataModel.curSquad = {}
  DataModel.curSquad = self:GetRoleDataList(currentSquad)
  local levelRoleList
  local blockedSlotCount = 0
  if DataModel.curLevelId ~= nil then
    local levelData = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
    if levelData.isUseLevelRole then
      DataModel.isUseLevelRole = true
    end
    levelRoleList = levelData.levelRoleList
    blockedSlotCount = levelData.roleNumOffSet
  end
  if DataModel.isUseLevelRole then
    DataModel.isHighChallenge = true
    DataModel.curSquad = {}
    for i = 1, #levelRoleList do
      if 0 < levelRoleList[i].id then
        local roleData = PlayerData:GetFactoryData(levelRoleList[i].id, "LevelRoleFactory")
        if roleData.usePlayerRoleData == true then
          local player_role = GetPlayerRoleData(roleData.unitId)
          if player_role ~= nil then
            roleData = player_role
          end
        end
        roleData.isLevelRole = true
        roleData.trustLv = 0
        DataModel.curSquad[i] = roleData
      end
    end
  end
  local len = squadCount - blockedSlotCount
  for i = #DataModel.curSquad + 1, len do
    if len >= #DataModel.curSquad then
      table.insert(DataModel.curSquad, {})
    end
  end
  for i = 1, blockedSlotCount do
    if DataModel.curSquad[i] == nil then
      DataModel.curSquad[i] = {}
      if DataModel.levelChainId == nil then
        DataModel.curSquad[i].isBlocked = true
      end
    end
  end
end

function module:RoleSort(sortList)
  local CompFunc = function(roleA, roleB)
    local a = PlayerData:GetFactoryData(roleA.unitId)
    local b = PlayerData:GetFactoryData(roleB.unitId)
    if a.line < b.line then
      return true
    elseif a.line > b.line then
      return false
    elseif a.id == b.id then
      return false
    elseif a.id > b.id then
      return false
    else
      return true
    end
  end
  table.sort(sortList, CompFunc)
end

function module:SetSquadIndex(index)
  DataModel.curSquadIndex = index
end

function module:ClearSquad()
  local Callback = function()
    PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = {}
    PlayerData.ServerData.squad[DataModel.curSquadIndex].header = ""
    DataModel:RefreshSquadsInit()
    self:ClearGridProperty(View.StaticGrid_List.grid)
    self:RefreshAll()
  end
  if DataModel.Current == DataModel.Enum.College or DataModel.hasLevelRole == true then
    PlayerData.currentSquad = {}
    self:ClearGridProperty(View.StaticGrid_List.grid)
    self:RefreshAll()
    return
  end
  Net:SendProto("deck.set_deck", function(json)
    Callback()
  end, DataModel.curSquadIndex - 1, "")
end

function module:GenSendServerRoleList(list)
  local roleListSendServer = {}
  for i = 1, #list do
    if type(list[i]) == "number" then
      table.insert(roleListSendServer, list[i])
    elseif list[i].isLevelRole ~= true and list[i].unitId ~= nil then
      table.insert(roleListSendServer, list[i].unitId)
    end
  end
  return roleListSendServer
end

function module:GenRoleIdList(roleList)
  local playerDataRoleIdList = {}
  for i = 1, #roleList do
    if roleList[i].isLevelRole ~= true and roleList[i].isBlocked ~= true and next(roleList[i]) ~= nil then
      local temp = {}
      temp.id = roleList[i].unitId
      table.insert(playerDataRoleIdList, temp)
    end
  end
  return playerDataRoleIdList
end

function module:ClearGridProperty(StaticGridList)
  for k, v in pairs(StaticGridList) do
    if v ~= nil and v ~= StaticGridList.self and v.Btn_Character then
      v.Btn_Character.current = nil
    end
  end
end

function module:GetRoleDataList(roleIdList)
  local roleDataList = {}
  for i = 1, #roleIdList do
    local squad_role = roleIdList[i]
    if squad_role.id == nil then
      table.insert(roleDataList, {})
    else
      local roleInfo = GetPlayerRoleData(roleIdList[i].id)
      table.insert(roleDataList, roleInfo)
    end
  end
  return roleDataList
end

function module:InitChallengeInfo()
  local configFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local levelList = configFactory.challengeLevelList
  DataModel.ChallengeInfo = {}
  for i, v in pairs(levelList) do
    local levelId = tonumber(v.levelId)
    if LevelCheck.CheckPreLevel(levelId) == true then
      local t = {}
      t.levelId = levelId
      local unitId = tonumber(v.unitId)
      local unitData = PlayerData:GetFactoryData(unitId, "unitFactory")
      local unitViewData = PlayerData:GetFactoryData(tonumber(unitData.viewId), "UnitViewFactory")
      local isUnlock = LevelCheck.CheckMonsterManualUnlock(levelId)
      t.unitId = unitId
      t.faceRes = unitViewData.face
      t.isUnlock = isUnlock
      t.name = unitData.name
      t.viewId = unitData.viewId
      t.isBoss = unitData.isBoss
      t.spineUrl = unitViewData.resDir
      t.lineDes = unitData.lineDes
      t.iconPath = unitViewData.face
      t.armorDes = unitData.armorDes
      t.riskDes = unitData.riskDes
      t.normalDes = unitData.normalDes
      t.battleDes = unitData.battleDes
      t.spineX = unitViewData.spineX
      t.spineY = unitViewData.spineY
      t.spineScale = unitViewData.spineScale
      t.resUrl = unitViewData.resUrl
      t.offsetX = unitViewData.offsetX
      t.offsetY = unitViewData.offsetY
      local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
      t.firstPassAward = Clone(levelCA.firstPassAward)
      table.insert(DataModel.ChallengeInfo, t)
    end
  end
end

function module:ShowChallengeDetail(idx)
  local info = DataModel.ChallengeInfo[idx]
  if info == nil then
    return
  end
  if not info.isUnlock then
    CommonTips.OpenTips(80600208)
    return
  end
  if DataModel.curShowIdx == idx then
    return
  end
  DataModel.curShowIdx = idx
  local panel = View.Group_ProvingGround.Group_EnemyDetail
  panel.Group_Details.Txt_Name:SetText(info.name)
  local transform = panel.Group_Anim.Img_Character.transform
  local pos = DataModel.curShowImgDefaultInfo
  local posX = pos.x + info.offsetX * pos.scale
  local posY = pos.y + info.offsetY * pos.scale
  transform.localPosition = Vector3(posX, posY, 0)
  panel.Group_Anim.Img_Character:SetActive(true)
  panel.Group_Anim.Img_Character:SetSprite(info.resUrl)
  panel.Group_Details.Group_Des.Txt_battleDes:SetText(info.battleDes)
  View.Group_ProvingGround.Group_EnemyDetail.Group_Blank.self:SetActive(false)
  local complete = PlayerData:GetLevelPass(info.levelId)
  View.Group_ProvingGround.Group_Challenge.Img_Received:SetActive(complete)
  View.Group_ProvingGround.Group_Challenge.Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  panel.self:SetActive(true)
end

return module
