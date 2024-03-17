local TrainWeaponTag = {}
local WeaponTag2Enum = {
  [12600349] = EnumDefine.TrainWeaponTagEnum.ElectricCost,
  [12600368] = EnumDefine.TrainWeaponTagEnum.TrainSpeed,
  [12600708] = EnumDefine.TrainWeaponTagEnum.TrainSpeed,
  [12600361] = EnumDefine.TrainWeaponTagEnum.TrainSpeed,
  [12600711] = EnumDefine.TrainWeaponTagEnum.RiseSpaceLimited,
  [12600828] = EnumDefine.TrainWeaponTagEnum.RushSpeed,
  [12600371] = EnumDefine.TrainWeaponTagEnum.RiseRushLimited,
  [12600370] = EnumDefine.TrainWeaponTagEnum.RiseRushUseTime,
  [12600351] = EnumDefine.TrainWeaponTagEnum.RiseDurabilityLimited,
  [12600359] = EnumDefine.TrainWeaponTagEnum.RiseDurabilityLimited,
  [12600348] = EnumDefine.TrainWeaponTagEnum.AddColoudness,
  [12600831] = EnumDefine.TrainWeaponTagEnum.AddColoudness,
  [12600344] = EnumDefine.TrainWeaponTagEnum.AddDeterrence,
  [12600832] = EnumDefine.TrainWeaponTagEnum.AddDeterrence,
  [12600350] = EnumDefine.TrainWeaponTagEnum.TrainHP,
  [12600829] = EnumDefine.TrainWeaponTagEnum.PassengerNum,
  [12600696] = EnumDefine.TrainWeaponTagEnum.TrainStartAddSpeed,
  [12600706] = EnumDefine.TrainWeaponTagEnum.TrainStoptAddSpeed,
  [12600363] = EnumDefine.TrainWeaponTagEnum.MonsterClickDistance,
  [12600407] = EnumDefine.TrainWeaponTagEnum.BoxClickDistance,
  [12600345] = EnumDefine.TrainWeaponTagEnum.TrainWeaponImpact,
  [12600862] = EnumDefine.TrainWeaponTagEnum.TrainWeaponDurability,
  [12600709] = EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff,
  [12600707] = EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff,
  [12600365] = EnumDefine.TrainWeaponTagEnum.AutoPickGoods,
  [12600830] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601063] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601064] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601065] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601066] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601067] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12600360] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601068] = EnumDefine.TrainWeaponTagEnum.TrainBattleBuff,
  [12601072] = EnumDefine.TrainWeaponTagEnum.AddBalloonSR,
  [12600710] = EnumDefine.TrainWeaponTagEnum.GoodsOverVal
}
local GetResult = function(param, initValue)
  local value = 0
  if param[1] then
    value = math.floor(initValue * param[1] + 0.5)
  end
  if param[2] then
    if 1 < param[2] then
      value = value + math.floor(param[2] + 0.5)
    else
      value = value + param[2]
    end
  end
  if param[3] then
    value = value + math.floor((value + initValue) * param[3] + 0.5)
  end
  return value
end
local HandleOneAttributes = function(weaponSkillId, lv, tagId, calValue, typeParam)
  local tagEnum = WeaponTag2Enum[tagId]
  local param = {0, 0}
  if calValue then
    param = TrainWeaponTag[tagEnum].param
  end
  if typeParam == nil then
    typeParam = {0, 0}
  end
  if calValue then
    if tagEnum == EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff then
      table.insert(param, weaponSkillId)
      return
    end
    if tagEnum == EnumDefine.TrainWeaponTagEnum.AutoPickGoods then
      TrainWeaponTag[tagEnum].param = true
      return
    end
    if tagEnum == EnumDefine.TrainWeaponTagEnum.TrainBattleBuff then
      local data = {
        tagId = tagId,
        weaponSkillId = weaponSkillId,
        lv = lv
      }
      table.insert(param, data)
      return
    end
  end
  local ca = PlayerData:GetFactoryData(weaponSkillId)
  local isAdd = PlayerData:GetFactoryData(tagId).addNum
  local param1 = isAdd == true and 1 or -1
  if ca.mod == "固定词条" then
    local value = ca.Constant * ca.CommonNum * param1
    param[2] = param[2] + value
    typeParam[2] = typeParam[2] + value
  elseif ca.mod == "成长词条" then
    if ca.aTypeInt == 1 then
      local valueA = ca.aNumMinP
      if ca.aDevelopment then
        valueA = (ca.aNumMinP + lv * ca.aUpgradeRangeP) * ca.aCommonNumP
      end
      local value = valueA * param1 / 100
      if tagId == 12600831 then
        param[3] = param[3] + value
        typeParam[3] = typeParam[3] + value
      else
        param[1] = param[1] + value
        typeParam[1] = typeParam[1] + value
      end
    else
      local valueA = ca.aNumMin
      if ca.aDevelopment then
        valueA = (ca.aNumMin + lv * ca.aUpgradeRange) * ca.aCommonNum
      end
      local value = valueA * param1
      param[2] = param[2] + value
      typeParam[2] = typeParam[2] + value
    end
  end
end

function TrainWeaponTag.CalOneweaponAttributes(weaponId, lv, typeStr)
  local cfg = PlayerData:GetFactoryData(weaponId)
  local typeParam
  local normalEntryList = cfg.normalEntryList
  for i, v in ipairs(normalEntryList) do
    local weaponSkillId = v.id
    local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
    local TagAttributes = TrainWeaponTag[WeaponTag2Enum[tagId]]
    if TagAttributes then
      if typeStr then
        typeParam = TagAttributes[typeStr]
      end
      HandleOneAttributes(weaponSkillId, lv, tagId, true, typeParam)
    end
  end
  local growUpEntryList = cfg.growUpEntryList
  for i, v in ipairs(growUpEntryList) do
    local weaponSkillId = v.id
    local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
    local TagAttributes = TrainWeaponTag[WeaponTag2Enum[tagId]]
    if TagAttributes then
      if typeStr then
        typeParam = TagAttributes[typeStr]
      end
      HandleOneAttributes(weaponSkillId, lv, tagId, true, typeParam)
    end
  end
end

function TrainWeaponTag.CalTrainWeaponAllAttributes()
  for k, v in pairs(WeaponTag2Enum) do
    if TrainWeaponTag[v] then
      if v == EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff then
        TrainWeaponTag[v].param = {}
      elseif v == EnumDefine.TrainWeaponTagEnum.AutoPickGoods then
        TrainWeaponTag[v].param = false
      elseif v == EnumDefine.TrainWeaponTagEnum.TrainBattleBuff then
        TrainWeaponTag[v].param = {}
      else
        TrainWeaponTag[v] = {
          param = {
            0,
            0,
            0
          },
          coach = {
            0,
            0,
            0
          },
          pendant = {
            0,
            0,
            0
          },
          accessories = {
            0,
            0,
            0
          }
        }
      end
    elseif v == EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff then
      TrainWeaponTag[v] = {
        param = {}
      }
    elseif v == EnumDefine.TrainWeaponTagEnum.AutoPickGoods then
      TrainWeaponTag[v] = {param = false}
    elseif v == EnumDefine.TrainWeaponTagEnum.TrainBattleBuff then
      TrainWeaponTag[v] = {
        param = {}
      }
    else
      TrainWeaponTag[v] = {
        param = {
          0,
          0,
          0
        },
        coach = {
          0,
          0,
          0
        },
        pendant = {
          0,
          0,
          0
        },
        accessories = {
          0,
          0,
          0
        }
      }
    end
  end
  local train_pendant = PlayerData:GetHomeInfo().train_pendant
  for k, v in pairs(train_pendant) do
    if v ~= "" then
      local serverBatteryData = PlayerData:GetBattery()[v]
      local weaponId = serverBatteryData.id
      local lv = serverBatteryData.lv
      TrainWeaponTag.CalOneweaponAttributes(weaponId, lv, "pendant")
    end
  end
  local train_accessories = PlayerData:GetHomeInfo().train_accessories
  for k, v in pairs(train_accessories) do
    if v ~= "" then
      local serverBatteryData = PlayerData:GetBattery()[v]
      local weaponId = serverBatteryData.id
      local lv = serverBatteryData.lv
      TrainWeaponTag.CalOneweaponAttributes(weaponId, lv, "accessories")
    end
  end
  local coach = PlayerData:GetHomeInfo().coach
  for i, v in ipairs(coach) do
    for i1, v1 in ipairs(v.battery) do
      if v1 ~= "" then
        local serverBatteryData = PlayerData:GetBattery()[v1]
        local weaponId = serverBatteryData.id
        local lv = serverBatteryData.lv
        TrainWeaponTag.CalOneweaponAttributes(weaponId, lv, "coach")
      end
    end
  end
end

function TrainWeaponTag.GetWeaponTagAttributes(enum, initValue, specialType)
  local value = 0
  local TagAttributes = TrainWeaponTag[enum]
  if TagAttributes then
    if initValue == nil then
      if specialType then
        return TagAttributes[specialType]
      else
        return TagAttributes.param
      end
    end
    if specialType then
      value = GetResult(TagAttributes[specialType], initValue)
    else
      value = GetResult(TagAttributes.param, initValue)
    end
  end
  return value
end

function TrainWeaponTag.GetOneCoachWeaponTagAttributes(enum, coachUid, initValue)
  local coach_store = PlayerData:GetHomeInfo().coach_store
  local t = {
    0,
    0,
    0
  }
  for i, v in pairs(coach_store) do
    if i == coachUid then
      for i1, v1 in pairs(v.battery) do
        if v1 ~= "" then
          local serverBatteryData = PlayerData:GetBattery()[v1]
          local weaponId = serverBatteryData.id
          local lv = serverBatteryData.lv
          local cfg = PlayerData:GetFactoryData(weaponId)
          local normalEntryList = cfg.normalEntryList
          for i2, v2 in ipairs(normalEntryList) do
            local weaponSkillId = v2.id
            local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
            local tagEnum = WeaponTag2Enum[tagId]
            if tagEnum == enum then
              HandleOneAttributes(weaponSkillId, lv, tagId, false, t)
            end
          end
          local growUpEntryList = cfg.growUpEntryList
          for i2, v2 in ipairs(growUpEntryList) do
            local weaponSkillId = v2.id
            local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
            local tagEnum = WeaponTag2Enum[tagId]
            if tagEnum == enum then
              HandleOneAttributes(weaponSkillId, lv, tagId, false, t)
            end
          end
        end
      end
    end
  end
  if initValue == nil then
    return t
  else
    return GetResult(t, initValue)
  end
end

function TrainWeaponTag.GetOneWeaponTagAttributes(enum, weaponUid, initValue)
  local serverWeapon = PlayerData:GetBattery()[weaponUid]
  if serverWeapon == nil then
    if initValue == nil then
      return {0, 0}
    end
    return 0
  end
  local cfg = PlayerData:GetFactoryData(serverWeapon.id)
  local lv = serverWeapon.lv
  local typeParam = {0, 0}
  local normalEntryList = cfg.normalEntryList
  for i, v in ipairs(normalEntryList) do
    local weaponSkillId = v.id
    local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
    local curEnum = WeaponTag2Enum[tagId]
    if curEnum == enum then
      HandleOneAttributes(weaponSkillId, lv, tagId, false, typeParam)
    end
  end
  local growUpEntryList = cfg.growUpEntryList
  for i, v in ipairs(growUpEntryList) do
    local weaponSkillId = v.id
    local tagId = PlayerData:GetFactoryData(weaponSkillId).entryTag
    local curEnum = WeaponTag2Enum[tagId]
    if curEnum == enum then
      HandleOneAttributes(weaponSkillId, lv, tagId, false, typeParam)
    end
  end
  if initValue == nil then
    return typeParam
  end
  return GetResult(typeParam, initValue)
end

function TrainWeaponTag.GetTrainLight()
  local train_accessories = PlayerData:GetHomeInfo().train_accessories
  for k, v in pairs(train_accessories) do
    if v ~= "" then
      local serverBatteryData = PlayerData:GetBattery()[v]
      local weaponCA = PlayerData:GetFactoryData(serverBatteryData.id, "HomeWeaponFactory")
      if weaponCA.typeWeapon == 12600388 and weaponCA.specialEffects ~= nil and weaponCA.specialEffects ~= "" then
        return tonumber(serverBatteryData.id)
      end
    end
  end
  return 0
end

function TrainWeaponTag.IsWeaponedById(id)
  id = tonumber(id)
  local train_pendant = PlayerData:GetHomeInfo().train_pendant
  for k, v in pairs(train_pendant) do
    if v ~= "" then
      local serverBatteryData = PlayerData:GetBattery()[v]
      if tonumber(serverBatteryData.id) == id then
        return true
      end
    end
  end
  local train_accessories = PlayerData:GetHomeInfo().train_accessories
  for k, v in pairs(train_accessories) do
    if v ~= "" then
      local serverBatteryData = PlayerData:GetBattery()[v]
      if tonumber(serverBatteryData.id) == id then
        return true
      end
    end
  end
  local coach = PlayerData:GetHomeInfo().coach
  for i, v in ipairs(coach) do
    for i1, v1 in ipairs(v.battery) do
      if v1 ~= "" then
        local serverBatteryData = PlayerData:GetBattery()[v1]
        if tonumber(serverBatteryData.id) == id then
          return true
        end
      end
    end
  end
  return false
end

return TrainWeaponTag
