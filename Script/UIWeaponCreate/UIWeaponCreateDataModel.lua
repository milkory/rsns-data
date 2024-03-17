local DataModel = {}

function DataModel.initData(info)
  DataModel.StationId = info.stationId
  DataModel.NpcId = info.npcId
  DataModel.BgPath = info.bgPath
  DataModel.BgColor = info.bgColor or "FFFFFF"
  local weaponCfg = PlayerData:GetFactoryData(99900044)
  DataModel.collisionAngleList = {}
  DataModel.accessoryList = {}
  DataModel.pendantList = {}
  for i, v in ipairs(weaponCfg.collisionAngleList) do
    local factoryName = DataManager:GetFactoryNameById(v.id)
    if factoryName == "ListFactory" then
      local data = PlayerData:GetFactoryData(v.id).trainWeaponList
      table.insert(DataModel.collisionAngleList, data)
    else
      table.insert(DataModel.collisionAngleList, {
        {
          id = v.id
        }
      })
    end
  end
  for i, v in ipairs(weaponCfg.accessoryList) do
    local factoryName = DataManager:GetFactoryNameById(v.id)
    if factoryName == "ListFactory" then
      local data = PlayerData:GetFactoryData(v.id).trainWeaponList
      table.insert(DataModel.accessoryList, data)
    else
      table.insert(DataModel.accessoryList, {
        {
          id = v.id
        }
      })
    end
  end
  for i, v in ipairs(weaponCfg.PendantList) do
    local factoryName = DataManager:GetFactoryNameById(v.id)
    if factoryName == "ListFactory" then
      local data = PlayerData:GetFactoryData(v.id).trainWeaponList
      table.insert(DataModel.pendantList, data)
    else
      table.insert(DataModel.pendantList, {
        {
          id = v.id
        }
      })
    end
  end
  DataModel.qualitybgPath = "UI/Home/weaponcreate/%s"
  DataModel.qualitBasePath = "UI/Common/Common_icon_rarity_%s"
  DataModel.qualityMap = {
    White = "N",
    Blue = "R",
    Purple = "SR",
    Golden = "SSR",
    Orange = "UR"
  }
  DataModel.strengthList = PlayerData:GetFactoryData(99900044).strengthList
  DataModel.maxLevel = DataModel.strengthList[#DataModel.strengthList].level
  DataModel.synthetic_list = {}
  for k, v in pairs(PlayerData:GetHomeInfo().home_battery) do
    if DataModel.synthetic_list[tonumber(v.id)] == nil then
      DataModel.synthetic_list[tonumber(v.id)] = {}
    end
    table.insert(DataModel.synthetic_list[tonumber(v.id)], {key = k, value = v})
  end
  DataModel.tabList = PlayerData:GetFactoryData(99900044).createTypeList
end

function DataModel.UpdateSyntheticList(battery, costWeaponkey)
  if costWeaponkey then
    local oldId = PlayerData:GetHomeInfo().home_battery[costWeaponkey].id
    PlayerData:GetHomeInfo().home_battery[costWeaponkey] = nil
    local tempList = DataModel.synthetic_list[tonumber(oldId)] or {}
    local delIndx = -1
    for i, v in ipairs(tempList) do
      if v.key == costWeaponkey then
        delIndx = i
        break
      end
    end
    if delIndx ~= -1 then
      table.remove(tempList, delIndx)
    end
  end
  for k, v in pairs(battery) do
    if DataModel.synthetic_list[tonumber(v.id)] == nil then
      DataModel.synthetic_list[tonumber(v.id)] = {}
    end
    table.insert(DataModel.synthetic_list[tonumber(v.id)], {key = k, value = v})
    PlayerData:GetHomeInfo().home_battery[k] = v
  end
end

function DataModel.SearchMaterialCount(material_id, material_type)
  local count = 0
  if material_type == 1 then
    count = PlayerData:GetGoodsById(material_id).num
  elseif material_type == 2 then
    local data = DataModel.synthetic_list[material_id]
    if data then
      count = #data
    end
  end
  return count
end

function DataModel.MaterialIsEnough(weapon_id)
  local cfg = PlayerData:GetFactoryData(weapon_id)
  local cost_list = cfg.TrainWeaponMakeUp or {}
  for i, v in ipairs(cost_list) do
    local material_type = DataManager:GetFactoryNameById(cost_list[i].id) == "HomeWeaponFactory" and 2 or 1
    local count = DataModel.SearchMaterialCount(cost_list[i].id, material_type)
    local need_count = cost_list[i].num
    if count < need_count then
      return false
    end
  end
  local cost = cfg.goldCost or 0
  if cost > PlayerData:GetUserInfo().gold then
    return false
  end
  return true
end

function DataModel.WeaponIsEquipment(costWeaponkey)
  local bagBatteryDetail = PlayerData:GetBattery()[costWeaponkey]
  if bagBatteryDetail.u_cid ~= "" then
    return true
  end
  return false
end

function DataModel.FindWeaponKey(weaponID)
  local data = DataModel.synthetic_list[weaponID]
  local key
  if data then
    local nowWeapon = data[1].value
    key = data[1].key
    for i, v in ipairs(data) do
      if nowWeapon.lv > v.value.lv then
        nowWeapon = v.value
        key = v.key
      elseif nowWeapon.lv == v.value.lv then
        local isEquipment = DataModel.WeaponIsEquipment(v.key)
        if isEquipment == false then
          nowWeapon = v.value
          key = v.key
        end
      end
    end
  end
  return key
end

function DataModel.FormatNum(num)
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num)
    if 0 < t2 - 1.0E-5 then
      return num
    else
      return t1
    end
  end
end

function DataModel.SetSelectTab(tab_indx)
  DataModel.tab_indx = tab_indx
  DataModel.select_indx = 1
  DataModel.weapon_id = DataModel.GetWeaponList()[1].id
end

function DataModel.GetWeaponList()
  if DataModel.tabList[DataModel.tab_indx].id == 12600303 then
    return DataModel.collisionAngleList
  elseif DataModel.tabList[DataModel.tab_indx].id == 12600862 then
    return DataModel.accessoryList
  elseif DataModel.tabList[DataModel.tab_indx].id == 12600301 then
    return DataModel.pendantList
  end
end

function DataModel.WeaponIsMade(weaponId)
  if weaponId == nil or weaponId <= 0 then
    return true
  end
  local madeList = PlayerData:GetHomeInfo().made_weapon
  for k, v in pairs(madeList) do
    if v == tostring(weaponId) then
      return true
    end
  end
  return false
end

function DataModel.UpdateWeaponMadelist(weaponId)
  local weaponId = tonumber(weaponId)
  if DataModel.WeaponIsMade(weaponId) == false then
    table.insert(PlayerData:GetHomeInfo().made_weapon, tostring(weaponId))
  end
end

return DataModel
