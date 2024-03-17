local DataModel = {
  itemList = {},
  curUseNum = 1,
  maxDiamondUseNum = 10
}

function DataModel.GetNowStatus()
  local nowNum = PlayerData:GetUserInfo().move_energy
  local homeEnergyStatementList = PlayerData:GetFactoryData(99900014).homeEnergyStatementList
  local homeCommon = require("Common/HomeCommon")
  local maxEnergy = homeCommon.GetMaxHomeEnergy()
  local nowRatio = MathEx.Clamp(nowNum / maxEnergy, 0, 1)
  for i, v in ipairs(homeEnergyStatementList) do
    if nowRatio >= v.ratioMin and nowRatio <= v.ratioMax then
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

function DataModel.init()
  DataModel.server_ts = TimeUtil:GetServerTimeStamp()
  DataModel.recover_num = PlayerData:GetFactoryData(99900014).homeEnergyAdd
  DataModel.recover_cd = PlayerData:GetFactoryData(99900014).homeEnergyAddCD
  if DataModel.server_ts >= PlayerData:GetUserInfo().move_energy_time and PlayerData:GetUserInfo().move_energy > 0 then
    local nowRecoverCnt = math.floor((DataModel.server_ts - PlayerData:GetUserInfo().move_energy_time) / DataModel.recover_cd)
    PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy - DataModel.recover_num * nowRecoverCnt
    PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + DataModel.recover_cd * nowRecoverCnt
    if PlayerData:GetUserInfo().move_energy < 0 then
      PlayerData:GetUserInfo().move_energy = 0
    end
  end
  DataModel.remain_ts = (DataModel.server_ts - PlayerData:GetUserInfo().move_energy_time) % DataModel.recover_cd
  DataModel.remain_ts = DataModel.recover_cd - DataModel.remain_ts
  local add_num = math.ceil(PlayerData:GetUserInfo().move_energy / DataModel.recover_num)
  DataModel.all_remain_ts = DataModel.remain_ts
  if 1 < add_num then
    DataModel.all_remain_ts = DataModel.all_remain_ts + (add_num - 1) * DataModel.recover_cd
  end
  if PlayerData:GetUserInfo().move_energy <= 0 then
    DataModel.all_remain_ts = -1
    DataModel.remain_ts = 0
  end
end

function DataModel.ResetTimer()
  if PlayerData:GetUserInfo().max_energy <= PlayerData:GetUserInfo().energy then
    DataModel.all_remain_ts = 0
    DataModel.remain_ts = 0
  else
    DataModel.remain_ts = DataModel.recover_cd
  end
  PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy - DataModel.recover_num
  if 0 > PlayerData:GetUserInfo().move_energy then
    PlayerData:GetUserInfo().move_energy = 0
  end
  PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + DataModel.recover_cd
end

function DataModel.FormatTime(seconds)
  seconds = seconds <= 0 and 0 or seconds
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor(seconds % 3600 / 60)
  local remainingSeconds = seconds % 60
  return string.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
end

return DataModel
