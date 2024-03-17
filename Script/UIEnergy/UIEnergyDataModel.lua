local DataModel = {}

function DataModel:init()
  self.energyId = 11400014
  self.rockcfg_id = 99900001
  local rockConfig = PlayerData:GetFactoryData(self.rockcfg_id, "ConfigFactory")
  self.energyAddMax = #rockConfig.energyMoneyCost
  self.rock_RemainNum = self.energyAddMax - PlayerData.ServerData.user_info.buy_energy_cnt
  self.bm_rockNum = PlayerData:GetUserInfo().bm_rock or 0
  local costIndex = math.min(PlayerData.ServerData.user_info.buy_energy_cnt + 1, self.energyAddMax)
  self.rock_NeedNum = rockConfig.energyMoneyCost[costIndex].num
  self.rock_GetEnergyNum = rockConfig.energyAddNum
  local item = PlayerData:GetFactoryData(self.energyId, "ItemFactory")
  self.owner_SutaminaBoxNum = PlayerData:GetGoodsById(self.energyId).num or 0
  self.sutaminaBox_getEnergyNum = item.exchangeList[1].num
  self.iconPath1 = item.iconPath
  DataModel.sutaminaBox_name = item.name
  local itemId = rockConfig.energyMoneyCost[costIndex].id
  self.iconPath2 = PlayerData:GetFactoryData(itemId, "ItemFactory").iconPath
  self.buyType = 1
  self.maxNum = self:GetMaxNum()
  self.selectNum = 1 <= self.maxNum and 1 or 0
  self.qualityId1 = item.qualityInt + 1
  local rockItemId = rockConfig.bmRockItemId
  self.qualityId2 = PlayerData:GetFactoryData(rockItemId, "ItemFactory").qualityInt + 1
  DataModel.server_ts = TimeUtil:GetServerTimeStamp()
  DataModel.recover_cd = PlayerData:GetFactoryData(99900007).energyAddCD
  DataModel.recover_num = PlayerData:GetFactoryData(99900007).energyAdd
  local timeDiff = DataModel.server_ts - PlayerData:GetUserInfo().energy_upd_time
  if 0 < timeDiff and PlayerData:GetUserInfo().energy < PlayerData:GetUserInfo().max_energy then
    local nowRecover = math.floor(timeDiff / DataModel.recover_cd)
    local nowEnergy = PlayerData:GetUserInfo().energy + nowRecover * DataModel.recover_num
    PlayerData:GetUserInfo().energy_upd_time = PlayerData:GetUserInfo().energy_upd_time + nowRecover * DataModel.recover_cd
    timeDiff = DataModel.server_ts - PlayerData:GetUserInfo().energy_upd_time
    PlayerData:GetUserInfo().energy = MathEx.Clamp(nowEnergy, 0, PlayerData:GetUserInfo().max_energy)
  end
  DataModel.remain_ts = timeDiff % DataModel.recover_cd
  DataModel.remain_ts = DataModel.recover_cd - DataModel.remain_ts
  local add_num = math.ceil((PlayerData:GetUserInfo().max_energy - PlayerData:GetUserInfo().energy) / DataModel.recover_num)
  DataModel.all_remain_ts = DataModel.remain_ts
  if 1 < add_num then
    DataModel.all_remain_ts = DataModel.all_remain_ts + (add_num - 1) * DataModel.recover_cd
  end
  if PlayerData:GetUserInfo().max_energy <= PlayerData:GetUserInfo().energy then
    DataModel.all_remain_ts = -1
    DataModel.remain_ts = 0
  end
  DataModel.item_list = rockConfig.energyItemList
  table.insert(DataModel.item_list, {id = itemId})
end

function DataModel:UpdateSelectNum(selectType)
  self:GetMaxNum()
  if selectType == 1 then
    self.selectNum = 1 <= self.maxNum and 1 or 0
  elseif selectType == 2 then
    self.selectNum = 1 <= self.selectNum - 1 and self.selectNum - 1 or 1
  elseif selectType == 3 then
    self.selectNum = self.selectNum + 1 <= self.maxNum and self.selectNum + 1 or self.maxNum
  end
  return self.selectNum
end

function DataModel:GetMaxNum()
  if self.buyType == 1 then
    self.maxNum = self.owner_SutaminaBoxNum
  else
    local maxNum = 0
    local cost = 0
    local rockConfig = PlayerData:GetFactoryData(self.rockcfg_id, "ConfigFactory")
    for i = PlayerData.ServerData.user_info.buy_energy_cnt + 1, DataModel.energyAddMax do
      cost = cost + rockConfig.energyMoneyCost[i].num
      if cost > self.bm_rockNum then
        break
      end
      maxNum = maxNum + 1
    end
    self.maxNum = math.min(maxNum, self.rock_RemainNum)
  end
  return self.maxNum
end

function DataModel:ReshBuyData()
  if self.buyType == 1 then
    self.owner_SutaminaBoxNum = PlayerData:GetGoodsById(self.energyId).num or 0
  else
    self.bm_rockNum = PlayerData:GetUserInfo().bm_rock or 0
    self.rock_RemainNum = self.energyAddMax - PlayerData.ServerData.user_info.buy_energy_cnt
    local rockConfig = PlayerData:GetFactoryData(self.rockId, "ConfigFactory")
    local costIndex = math.min(PlayerData.ServerData.user_info.buy_energy_cnt + 1, self.energyAddMax)
    self.rock_NeedNum = rockConfig.energyMoneyCost[costIndex].num
  end
  self:GetMaxNum()
  self.selectNum = 1 <= self.maxNum and 1 or 0
end

function DataModel.SelectType()
  return DataModel.bm_rockNum >= DataModel.rock_NeedNum and DataModel.rock_RemainNum > 0 and 0 >= DataModel.owner_SutaminaBoxNum and 2 or 1
end

function DataModel.ResetTimer()
  if PlayerData:GetUserInfo().max_energy <= PlayerData:GetUserInfo().energy then
    DataModel.all_remain_ts = 0
    DataModel.remain_ts = 0
  else
    DataModel.remain_ts = DataModel.recover_cd
  end
  PlayerData:GetUserInfo().energy = PlayerData:GetUserInfo().energy + DataModel.recover_num
  PlayerData:GetUserInfo().energy = MathEx.Clamp(PlayerData:GetUserInfo().energy, 0, PlayerData:GetUserInfo().max_energy)
  PlayerData:GetUserInfo().energy_upd_time = PlayerData:GetUserInfo().energy_upd_time + DataModel.recover_cd
end

function DataModel.FormatTime(seconds)
  seconds = seconds <= 0 and 0 or seconds
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor(seconds % 3600 / 60)
  local remainingSeconds = seconds % 60
  return string.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
end

function DataModel.RefreshSutaminaBox(energyId)
  DataModel.energyId = energyId
  local item = PlayerData:GetFactoryData(DataModel.energyId, "ItemFactory")
  DataModel.owner_SutaminaBoxNum = PlayerData:GetGoodsById(DataModel.energyId).num or 0
  DataModel.sutaminaBox_getEnergyNum = item.exchangeList[1].num
  DataModel.iconPath1 = item.iconPath
  DataModel.qualityId1 = item.qualityInt + 1
  DataModel.sutaminaBox_name = item.name
end

function DataModel.GetBgStatusImgPath()
  local status_list = PlayerData:GetFactoryData(99900001).energyStatementList
  local energy_status = PlayerData:GetUserInfo().energy / PlayerData:GetUserInfo().max_energy
  energy_status = MathEx.Clamp(energy_status, 0, 1)
  for i, v in ipairs(status_list) do
    if energy_status >= v.ratioMin and energy_status <= v.ratioMax then
      return i, v
    end
  end
end

function DataModel.GetLastLimitTimeItem(id)
  local curTime = TimeUtil:GetServerTimeStamp()
  local minTime = 0
  local recordInfo
  for k, v in pairs(PlayerData:GetLimitedItems()) do
    if v.id == tostring(id) and curTime < v.dead_line and (minTime == 0 or minTime > v.dead_line) then
      minTime = v.dead_line
      recordInfo = v
    end
  end
  return recordInfo
end

function DataModel.GetLimitTimeItem(id)
  local t = {}
  local curTime = TimeUtil:GetServerTimeStamp()
  for k, v in pairs(PlayerData:GetLimitedItems()) do
    if v.id == tostring(id) and curTime < v.dead_line then
      local temp = {}
      temp.id = v.id
      temp.dead_line = v.dead_line
      temp.uid = k
      table.insert(t, temp)
    end
  end
  table.sort(t, function(a, b)
    return a.dead_line < b.dead_line
  end)
  return t
end

return DataModel
