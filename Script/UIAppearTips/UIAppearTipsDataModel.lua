local DataModel = {}
local CalDaysBetween = function(ts1, ts2)
  local diff = ts2 - ts1
  local days = diff / 86400
  if 1 <= days then
    days = math.ceil(days)
    return string.format(GetText(80601335), days)
  else
    local hours = math.ceil(diff / 3600)
    return string.format(GetText(80601336), hours)
  end
end

function DataModel.init(data)
  DataModel.level_key = data.level_key
  DataModel.value_num = data.value_num
  local level_id = string.split(data.level_key, ":")[1]
  local cfg = PlayerData:GetFactoryData(level_id)
  DataModel.pay_min = math.floor(cfg.rewardCoefficientMin * DataModel.value_num)
  DataModel.pay_max = math.floor(cfg.rewardCoefficientMax * DataModel.value_num)
  DataModel.pay_max = math.min(DataModel.pay_max, PlayerData:GetUserInfo().gold)
  DataModel.remain_ts = CalDaysBetween(TimeUtil:GetServerTimeStamp(), data.created_ts + cfg.caseTimeLimit * 24 * 60 * 60)
  DataModel.levelStarInt = cfg.levelStarInt + 1
  DataModel.levelName = cfg.levelName
  DataModel.now_value = DataModel.pay_min
end

return DataModel
