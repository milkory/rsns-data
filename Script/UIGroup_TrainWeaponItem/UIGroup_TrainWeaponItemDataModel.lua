local DataModel = {}

function DataModel.WeaponIsEquipByUid(uid)
  local serverBatteryData = PlayerData:GetBattery()[uid]
  if serverBatteryData.u_cid then
    return serverBatteryData.u_cid ~= ""
  end
  local train_pendant = PlayerData:GetHomeInfo().train_pendant
  for k, v in pairs(train_pendant) do
    if v ~= "" and v == Uid then
      return true
    end
  end
  local train_accessories = PlayerData:GetHomeInfo().train_accessories
  for k, v in pairs(train_accessories) do
    if v ~= "" and v == Uid then
      return true
    end
  end
  return false
end

function DataModel.init(weaponId, weaponUid)
  DataModel.own = weaponUid ~= nil
  DataModel.weaponId = weaponId
  DataModel.lv = 0
  DataModel.isEquip = false
  if DataModel.own then
    local serverData = PlayerData:GetBattery()[weaponUid]
    DataModel.lv = serverData.lv
    DataModel.isEquip = DataModel.WeaponIsEquipByUid(weaponUid)
  end
  DataModel.weaponUid = weaponUid
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
