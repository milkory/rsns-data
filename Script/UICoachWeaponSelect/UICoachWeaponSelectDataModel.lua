local DataModel = {
  ShowType = {Train = 1, Other = 2},
  WeaponType = {
    Weapon = 1,
    Parts = 2,
    Pendant = 3
  },
  SortType = {QualityUp = 0, QualityDown = 1},
  OperatorType = {
    Change = 1,
    Remove = 2,
    Use = 3
  },
  toWeaponPosInfo = {},
  curWeaponIngInfo = nil,
  bagInfo = {},
  partsInfo = {},
  pendantInfo = {},
  curSelectBottomIdx = 0,
  curSelectTypeWeaponIdx = 0,
  curShowBagInfo = {},
  curSelectIdx = 0,
  curSelWeaponOperatorType = 0,
  curSortType = 1,
  FirstIn = false
}

function DataModel.Init()
  DataModel.bagInfo = {}
  DataModel.curSortType = PlayerData:GetPlayerPrefs("int", "TrainWeaponSort")
  DataModel.partsInfo = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.accessoryList) do
    local t = {}
    t.weaponTypeId = v.id
    table.insert(DataModel.partsInfo, t)
  end
  DataModel.pendantInfo = {}
  local pendantElectricList = PlayerData:GetFactoryData(99900044).pendantElectricList
  for i, v in ipairs(pendantElectricList) do
    DataModel.pendantInfo[i] = {
      weaponTypeId = 12600301,
      needElectricLv = v.id
    }
  end
end

function DataModel.GetCurShowBagInfo()
  local weaponIdx = DataModel.toWeaponPosInfo.weaponIdx
  local typeWeaponKey = {}
  local weaponTypeId
  if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon then
    local coachCA = PlayerData:GetFactoryData(DataModel.toWeaponPosInfo.coachId, "HomeCoachFactory")
    if weaponIdx <= #coachCA.weaponTypeList then
      local typeWeaponListId = coachCA.weaponTypeList[weaponIdx].id
      local typeWeaponListCA = PlayerData:GetFactoryData(typeWeaponListId, "ListFactory")
      local needAddWeaponKey = {}
      for k, v in pairs(typeWeaponListCA.normalTagList) do
        typeWeaponKey[v.id] = 0
        if DataModel.bagInfo[v.id] == nil then
          needAddWeaponKey[v.id] = 0
          DataModel.bagInfo[v.id] = {}
        end
      end
      if 0 < table.count(needAddWeaponKey) then
        for k, v in pairs(PlayerData:GetBattery()) do
          local id = tonumber(v.id)
          local weaponCA = PlayerData:GetFactoryData(id, "HomeWeaponFactory")
          if needAddWeaponKey[weaponCA.typeWeapon] then
            local info = {}
            info.id = id
            info.uid = k
            info.serverInfo = v
            info.qualityInt = weaponCA.qualityInt
            table.insert(DataModel.bagInfo[weaponCA.typeWeapon], info)
          end
        end
      end
    end
    local t = {}
    local n = 1
    local typeWeaponId = 0
    for k, v in pairs(typeWeaponKey) do
      typeWeaponId = k
      for k1, v1 in pairs(DataModel.bagInfo[k]) do
        t[n] = v1
        n = n + 1
      end
    end
    return t, typeWeaponId
  elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Parts then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    weaponTypeId = homeConfig.accessoryList[weaponIdx].id
  elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Pendant then
    weaponTypeId = 12600301
  end
  if DataModel.bagInfo[weaponTypeId] == nil then
    DataModel.bagInfo[weaponTypeId] = {}
    for k, v in pairs(PlayerData:GetBattery()) do
      local id = tonumber(v.id)
      local weaponCA = PlayerData:GetFactoryData(id, "HomeWeaponFactory")
      if weaponTypeId == weaponCA.typeWeapon then
        local info = {}
        info.id = id
        info.uid = k
        info.serverInfo = v
        info.qualityInt = weaponCA.qualityInt
        table.insert(DataModel.bagInfo[weaponCA.typeWeapon], info)
      end
    end
  end
  local t = {}
  local n = 1
  for k, v in pairs(DataModel.bagInfo[weaponTypeId]) do
    t[n] = v
    n = n + 1
  end
  return t, weaponTypeId
end

function DataModel.SortTrainWeaponBag(t, sortType)
  local isQualityUp = false
  if sortType == DataModel.SortType.QualityUp then
    isQualityUp = true
  elseif sortType == DataModel.SortType.QualityDown then
    isQualityUp = false
  end
  local curWeaponUid = DataModel.curWeaponIngInfo and DataModel.curWeaponIngInfo.uid or ""
  table.sort(t, function(a, b)
    if a.uid == curWeaponUid then
      return true
    elseif b.uid == curWeaponUid then
      return false
    end
    if a.qualityInt > b.qualityInt then
      return isQualityUp
    elseif a.qualityInt < b.qualityInt then
      return not isQualityUp
    end
    return a.id < b.id
  end)
end

function DataModel.GetCurWeaponInfo()
  local info, uid
  if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon then
    local coachServerInfo = PlayerData:GetHomeInfo().coach_store[DataModel.toWeaponPosInfo.coachUid]
    uid = coachServerInfo.battery[DataModel.toWeaponPosInfo.weaponIdx] or ""
  elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Parts then
    uid = PlayerData:GetHomeInfo().train_accessories[DataModel.toWeaponPosInfo.weaponIdx] or ""
  elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Pendant then
    uid = PlayerData:GetHomeInfo().train_pendant[DataModel.toWeaponPosInfo.weaponIdx] or ""
  end
  if uid ~= "" then
    info = {}
    local batteryInfo = PlayerData:GetBattery()[uid]
    info.id = tonumber(batteryInfo.id)
    info.uid = uid
    info.ucid = DataModel.toWeaponPosInfo.coachUid
  end
  return info
end

function DataModel.FormatNum(num)
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num + 1.0E-6)
    if 0 < t2 - 1.0E-5 then
      return num
    else
      return t1
    end
  end
end

return DataModel
