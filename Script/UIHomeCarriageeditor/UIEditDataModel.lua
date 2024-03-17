local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local DataModel = {
  curPresetIdx = 0,
  curCoachTypeSelect = 0,
  coachInfo = {},
  coachTypes = {},
  coachBagInfo = {},
  coachHeadUid = "",
  coachHeadInfo = {},
  isEditMode = false,
  isDrag = false,
  dragIdx = 0,
  dragIsCoachBag = false,
  curUsedCoachCount = 0,
  curShowDetailCharacter = {},
  trainSize = {x = 282, y = 222},
  trainMiddleSizeOffset = 40,
  recordEnterCoachIds = {},
  coachId = 81200030,
  isBuilding = false,
  emptyPath = "UI/Trainfactory/Edit/CarriageType/empty",
  lastHighLightElement = {},
  RenameIdx = 0,
  CanExpand = false,
  MaxElementCount = -1,
  GetCoachInfo = nil,
  IsCanAddNewCoach = false
}

function DataModel.InitEditData(presetIdx)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  DataModel.coachId = homeConfig.buildList[1].id
  DataModel.coachInfo = {}
  local coachIds = PlayerData:GetHomeInfo().coach_template
  local useCoachRecord = {}
  DataModel.curUsedCoachCount = 0
  for k, v in pairs(coachIds) do
    if k ~= 1 then
      local t = {}
      local coachInfo = PlayerData:GetHomeInfo().coach_store[v]
      t.id = tonumber(coachInfo.id)
      t.uid = v
      t.checkName = ""
      DataModel.AddCAInfo(t, t.id, t.uid)
      if t.name ~= coachInfo.name then
        t.checkName = coachInfo.name
      end
      t.name = coachInfo.name
      DataModel.curUsedCoachCount = DataModel.curUsedCoachCount + 1
      table.insert(DataModel.coachInfo, t)
    else
      DataModel.coachHeadUid = v
      local coachHeadInfo = {}
      local coachInfo = PlayerData:GetHomeInfo().coach_store[v]
      coachHeadInfo.id = tonumber(coachInfo.id)
      coachHeadInfo.uid = v
      coachHeadInfo.checkName = ""
      DataModel.AddCAInfo(coachHeadInfo, coachHeadInfo.id, coachHeadInfo.uid)
      if coachHeadInfo.name ~= coachInfo.name then
        coachHeadInfo.checkName = coachInfo.name
      end
      coachHeadInfo.name = coachInfo.name
      DataModel.coachHeadInfo = coachHeadInfo
    end
    useCoachRecord[v] = 0
  end
  DataModel.coachTypes = {}
  DataModel.coachBagInfo = {}
  for k, v in pairs(homeConfig.normalCarriageList) do
    table.insert(DataModel.coachTypes, v.id)
    DataModel.coachBagInfo[v.id] = {}
  end
  local coachStore = PlayerData:GetHomeInfo().coach_store
  for k, v in pairs(coachStore) do
    if useCoachRecord[k] == nil then
      local t = {}
      t.id = tonumber(v.id)
      t.uid = k
      t.checkName = ""
      DataModel.AddCAInfo(t, t.id, t.uid)
      if t.name ~= v.name then
        t.checkName = v.name
      end
      t.name = v.name
      local saveT = DataModel.coachBagInfo[t.coachType]
      if saveT ~= nil then
        table.insert(saveT, t)
      end
    end
  end
  DataModel.SortBagInfo(-1)
end

function DataModel.AddCAInfo(t, id, uid)
  local ca = PlayerData:GetFactoryData(id, "HomeCoachFactory")
  local serverCoachInfo = PlayerData:GetHomeInfo().coach_store[uid]
  t.space = ca.space
  t.name = ca.name
  t.thumbnail = ca.thumbnail
  if serverCoachInfo.skin then
    local skinCA = PlayerData:GetFactoryData(serverCoachInfo.skin, "HomeCoachSkinFactory")
    t.thumbnail = skinCA.thumbnail
  end
  t.thumbnail2 = ca.thumbnailone
  t.electricCost = ca.electricCost
  t.speedEffect = ca.speedEffect
  t.carriagedurability = ca.carriagedurability
  t.weaponNum = ca.weaponNum
  t.coachType = ca.coachType
  t.weaponTypeList = ca.weaponTypeList
  t.armor = ca.Armor
  t.passengerCapacity = 0
  local coachFurs = HomeFurnitureCollection.GetCoach2FurMap()
  if coachFurs[uid] then
    for k, v in pairs(coachFurs[uid]) do
      local furCA = PlayerData:GetFactoryData(v)
      t.passengerCapacity = t.passengerCapacity + furCA.addPassengerCapacity
    end
  end
  local weaponSpeedEffect = TrainWeaponTag.GetOneCoachWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, uid, PlayerData:GetHomeInfo().speed)
  t.speedEffect = t.speedEffect + weaponSpeedEffect
  t.electricCost = t.electricCost + TrainWeaponTag.GetOneCoachWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, uid, 0)
end

function DataModel.SortBagInfo(coachType)
  local sortFunc = function(t)
    table.sort(t, function(a, b)
      return a.id < b.id
    end)
  end
  if coachType == -1 then
    for k, v in pairs(DataModel.coachBagInfo) do
      sortFunc(v)
    end
  else
    sortFunc(DataModel.coachBagInfo[coachType])
  end
end

function DataModel.GetCurCoachBagInfo(idx)
  if DataModel.curCoachTypeSelect == -1 then
    for k, v in pairs(DataModel.coachTypes) do
      local count = #DataModel.coachBagInfo[v]
      if idx > count then
        idx = idx - count
      else
        return DataModel.coachBagInfo[v][idx]
      end
    end
  else
    return DataModel.coachBagInfo[DataModel.curCoachTypeSelect][idx]
  end
end

function DataModel.RemoveCurCoachBagInfo(idx)
  if DataModel.curCoachTypeSelect == -1 then
    for k, v in pairs(DataModel.coachTypes) do
      local count = #DataModel.coachBagInfo[v]
      if idx > count then
        idx = idx - count
      else
        table.remove(DataModel.coachBagInfo[v], idx)
        break
      end
    end
  else
    table.remove(DataModel.coachBagInfo[DataModel.curCoachTypeSelect], idx)
  end
end

function DataModel.BagToUse(bagIdx, toIdx)
  local bagInfo = DataModel.GetCurCoachBagInfo(bagIdx)
  if bagInfo == nil then
    return false
  end
  if DataModel.curUsedCoachCount + 1 > MainDataModel.maxCoachNum - 1 then
    CommonTips.OpenTips(80601058)
    return false
  end
  if bagInfo.electricCost + DataModel.GetCurPowCost() > PlayerData.GetMaxElectric() then
    CommonTips.OpenTips(80601263)
    return false
  end
  DataModel.curUsedCoachCount = DataModel.curUsedCoachCount + 1
  if toIdx == nil then
    table.insert(DataModel.coachInfo, bagInfo)
  else
    local coachCount = table.count(DataModel.coachInfo)
    if toIdx >= coachCount + 1 then
      table.insert(DataModel.coachInfo, bagInfo)
    else
      table.insert(DataModel.coachInfo, toIdx, bagInfo)
    end
  end
  DataModel.RemoveCurCoachBagInfo(bagIdx)
  return true
end

function DataModel.UseToBag(useIdx)
  local coachInfo = DataModel.coachInfo[useIdx]
  if MainDataModel.IsInitCoach(coachInfo.uid) then
    CommonTips.OpenTips(80601330)
    return false
  end
  local user_info = PlayerData:GetUserInfo()
  if coachInfo.space > 0 and PlayerData.GetMaxTrainGoodsNum() - coachInfo.space < user_info.space_info.now_train_goods_num then
    CommonTips.OpenTips(80600405)
    return false
  end
  if MainDataModel.PassengerCoach[coachInfo.uid] then
    CommonTips.OpenTips(80601276)
    return false
  end
  local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
  if 0 > serverRepairInfo.current_durable - coachInfo.carriagedurability then
    CommonTips.OpenTips(80601301)
    return false
  end
  local afterUnloadFridgeNum = PlayerData:GetUserInfo().space_info.max_food_material_num
  for i, v in pairs(PlayerData:GetFurniture()) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600294 and v.u_cid == coachInfo.uid then
      afterUnloadFridgeNum = afterUnloadFridgeNum - furCA.FridgeNum
    end
  end
  if afterUnloadFridgeNum < PlayerData:GetUserInfo().space_info.now_food_material_num then
    CommonTips.OpenTips(80601377)
    return
  end
  table.remove(DataModel.coachInfo, useIdx)
  DataModel.curUsedCoachCount = DataModel.curUsedCoachCount - 1
  table.insert(DataModel.coachBagInfo[coachInfo.coachType], coachInfo)
  DataModel.SortBagInfo(coachInfo.coachType)
  return true
end

function DataModel.UseChangeIdx(useIdx, toIdx)
  if useIdx < toIdx then
    toIdx = toIdx - 1
  end
  if useIdx == toIdx or toIdx > #DataModel.coachInfo then
    return false
  end
  local info = DataModel.coachInfo[useIdx]
  table.remove(DataModel.coachInfo, useIdx)
  table.insert(DataModel.coachInfo, toIdx, info)
  return true
end

function DataModel.SwapCoachAndBag(bagIdx, useIdx)
  local bagInfo = DataModel.GetCurCoachBagInfo(bagIdx)
  local coachInfo = DataModel.coachInfo[useIdx]
  if coachInfo == nil then
    local complete = DataModel.BagToUse(bagIdx)
    return complete
  end
  if MainDataModel.IsInitCoach(coachInfo.uid) then
    CommonTips.OpenTips(80601330)
    return false
  end
  local user_info = PlayerData:GetUserInfo()
  if PlayerData.GetMaxTrainGoodsNum() + bagInfo.space - coachInfo.space < user_info.space_info.now_train_goods_num then
    CommonTips.OpenTips(80600405)
    return false
  end
  local homeInfo = PlayerData:GetHomeInfo()
  if homeInfo.electric_used + bagInfo.electricCost - coachInfo.electricCost > PlayerData.GetMaxElectric() then
    CommonTips.OpenTips(80601263)
    return false
  end
  local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
  if serverRepairInfo.current_durable + bagInfo.carriagedurability - coachInfo.carriagedurability < 0 then
    CommonTips.OpenTips(80601301)
    return false
  end
  DataModel.RemoveCurCoachBagInfo(bagIdx)
  table.remove(DataModel.coachInfo, useIdx)
  table.insert(DataModel.coachBagInfo[coachInfo.coachType], coachInfo)
  DataModel.SortBagInfo(coachInfo.coachType)
  table.insert(DataModel.coachInfo, useIdx, bagInfo)
  return true
end

function DataModel.SelectPreset(idx)
  DataModel.InitEditData(idx)
end

function DataModel.UsePreset()
  local coachInfos = PlayerData:GetHomeInfo().coach_template
  PlayerData:GetHomeInfo().coach = {}
  local useCoachRecord = {}
  for k, v in pairs(coachInfos) do
    local uid = v
    local coachInfo = PlayerData:GetHomeInfo().coach_store[uid]
    useCoachRecord[v] = 1
    table.insert(PlayerData:GetHomeInfo().coach, coachInfo)
  end
  TrainWeaponTag.CalTrainWeaponAllAttributes()
  local electric = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    electric = electric + coachCA.electricCost
    for k1, v1 in pairs(v.location) do
      local furInfo = PlayerData:GetHomeInfo().furniture[v1.id]
      local furCA = PlayerData:GetFactoryData(furInfo.id, "HomeFurnitureFactory")
      electric = electric + furCA.electricCost
    end
  end
  electric = electric + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, 0)
  PlayerData:GetHomeInfo().electric_used = electric
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    if v.u_cid ~= nil and useCoachRecord[v.u_cid] == nil then
      if v.roles ~= nil then
        for k1, v1 in pairs(v.roles) do
          if v1 ~= nil and v1 ~= "" then
            PlayerData.ServerData.roles[v1].u_fid = nil
          end
        end
      end
      v.roles = nil
    end
  end
end

function DataModel.SwapCoach(idx1, idx2)
  local t1 = DataModel.coachInfo[idx1]
  local t2 = DataModel.coachInfo[idx2]
  DataModel.coachInfo[idx1] = t2
  DataModel.coachInfo[idx2] = t1
end

function DataModel.CompareIsEdit()
  local template = PlayerData:GetHomeInfo().coach_template
  if #template ~= #DataModel.coachInfo + 1 then
    return true
  end
  local noEdit = true
  noEdit = noEdit and template[1] == DataModel.coachHeadUid
  for k, v in pairs(DataModel.coachInfo) do
    noEdit = noEdit and template[k + 1] == v.uid
    if noEdit == false then
      break
    end
  end
  return not noEdit
end

function DataModel.GetCurPowCost()
  local powerCost = DataModel.coachHeadInfo.electricCost
  for k, v in pairs(DataModel.coachInfo) do
    powerCost = powerCost + v.electricCost
  end
  powerCost = powerCost + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, 0, "pendant") + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, 0, "accessories")
  return powerCost
end

return DataModel
