local DataModel = {}
local CreateRewardData = function(lost_reward, level_id)
  local data = {}
  local isOnline = true
  if lost_reward and next(lost_reward) then
    for k, v in pairs(lost_reward) do
      table.insert(data, {
        id = v.id,
        num = v.num,
        lost = 1
      })
    end
    isOnline = false
  end
  if level_id then
    local levelCA = PlayerData:GetFactoryData(level_id)
    local dropTableList = levelCA.dropTableList
    local dropListCA = PlayerData:GetFactoryData(dropTableList[1].listId, "ListFactory")
    local drop_list = dropListCA.leveldropList
    if isOnline then
      local shareList = levelCA.shareList or {}
      for i, v in ipairs(shareList) do
        table.insert(data, {
          id = v.itemId,
          num = "",
          share = 1
        })
      end
    end
    for k, v in pairs(drop_list) do
      table.insert(data, {
        id = v.id,
        num = "",
        lost = 0,
        share = 0
      })
    end
  end
  return data
end
local CreatePersonalData = function(level_data)
  local person_count = 0
  local achieve_count = 0
  for k, v in pairs(level_data) do
    v.key = k
    local level_id = string.split(k, ":")[1]
    if v.completed_ts == 0 then
      person_count = person_count + 1
      v.reward_list = CreateRewardData(v.lost_reward, level_id)
      table.insert(DataModel.person_list, v)
    else
      achieve_count = achieve_count + 1
      v.reward_list = CreateRewardData(v.lost_reward, nil)
      table.insert(DataModel.achieve_list, v)
    end
  end
  DataModel.person_list.count = person_count
  DataModel.achieve_list.count = achieve_count
  table.sort(DataModel.person_list, function(a, b)
    if a.is_shared ~= b.is_shared then
      return a.is_shared > b.is_shared
    end
    return a.created_ts > b.created_ts
  end)
  table.sort(DataModel.achieve_list, function(a, b)
    if a.received_ts ~= 0 and b.received_ts == 0 then
      return false
    end
    if a.received_ts == 0 and b.received_ts ~= 0 then
      return true
    end
    return a.completed_ts < b.completed_ts
  end)
end
local CreateOnlineData = function(rec_levels)
  local count = 0
  DataModel.online_list = {}
  for k, v in pairs(rec_levels) do
    v.key = k
    count = count + 1
    local level_id = string.split(k, ":")[2]
    v.reward_list = CreateRewardData(nil, level_id)
    table.insert(DataModel.online_list, v)
  end
  DataModel.online_list.count = count
  table.sort(DataModel.online_list, function(a, b)
    if a.reward_num ~= b.reward_num then
      return a.reward_num > b.reward_num
    end
    return a.created_ts < b.created_ts
  end)
end
local InitRouteLevelDataModel = function(levels)
  DataModel.refreshOnlienData = true
  DataModel.refreshTimer = 3
  DataModel.person_list = {count = 0}
  DataModel.online_list = {count = 0}
  DataModel.achieve_list = {count = 0}
  CreatePersonalData(levels)
  DataModel.first_open_online = true
  DataModel.cancel_coefficient = PlayerData:GetFactoryData(99900014).returnCoefficient
end
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
DataModel.InitRouteLevelDataModel = InitRouteLevelDataModel
DataModel.CreateOnlineData = CreateOnlineData
DataModel.CalDaysBetween = CalDaysBetween
return DataModel
